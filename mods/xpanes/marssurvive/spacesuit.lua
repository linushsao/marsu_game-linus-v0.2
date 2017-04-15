--NEW (for sp registration)
local stack_one_sp = function(inventory)
        return string.sub(inventory:get_stack("main", 1):get_name(), 1, 14)=="marssurvive:sp"
end

local set_wear_sp = function(inventory, wear)
        local name = inventory:get_stack("main", 1):get_name()
        inventory:set_stack("main", 1,ItemStack({name=name,wear=wear}))
end

local player_get_sp = function(inventory)
--  print("get_sp:"..inventory:get_stack("main", 1):get_name().."#")
--  print("get_sp_sub:"..string.sub(inventory:get_stack("main", 1):get_name(), 15).."#")

        return marssurvive.registered_spacesuits[string.sub(inventory:get_stack("main", 1):get_name(), 15)]
end

local player_attach_sp = function(player)
        marssurvive.player_sp[player:get_player_name()].sp=1
        local sp=player_get_sp(player:get_inventory())
        marssurvive.player_sp[player:get_player_name()].skin=player:get_properties().textures
 --       print(dump(sp))
 --       print(dump(sp.textures))
 --       print(player:get_player_name())
        local spp = player:get_inventory():get_stack("main", 1):get_name()
  --      print("SUIT is:"..spp)
        if spp ~= "marssurvive:spred" and spp ~= "marssurvive:spblue" and md0_config then
          sp.textures = sp.textures and {textures_switch(player:get_player_name())}
        end
	player:set_properties({visual = "mesh",textures = sp.textures , visual_size = {x=1, y=1}})
end

marssurvive.registered_spacesuits = {}

marssurvive.register_spacesuit = function(name, inventory_image, heal, textures)
        local tool_name = "marssurvive:sp" .. name
	marssurvive.registered_spacesuits[name] = {heal=heal, textures=textures}
	minetest.register_tool(tool_name, {
	        description = "Spacesuit " .. name .. " (wear slot 1)",
	        range = 4,
	        inventory_image = inventory_image,
        })
end

marssurvive.register_spacesuit("", "marssurvive_sp.png", 1, {"marssurvive_sp_white.png"})
marssurvive.register_spacesuit("red", "marssurvive_sp_inv-red.png", 2, {"marssurvive_sp_red.png"})
marssurvive.register_spacesuit("blue", "marssurvive_sp_inv-blue.png", 3, {"marssurvive_sp_blue.png"})

--CRAFT

--GASSBOTTLE
minetest.register_node("marssurvive:air_gassbotte", {
	description = "Air gassbotte",
	tiles = {"default_steel_block.png"},
	inventory_image = "gassbottle_full.png",
	drawtype = "nodebox",
	groups = {dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	--paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.1,-0.5,-0.1,0.1,0.3,0.1}},
})

minetest.register_craftitem("marssurvive:air_gassbotte_empty", {
        description = "empty Air gassbotte",
        inventory_image = "gassbottle_empty.png",
    	on_place = function(itemstack, user, pointed_thing)
	        local node = minetest.get_node(pointed_thing.under)
	        if string.sub(node.name, 1, 18) == "marssurvive:airgen" then
		        itemstack:set_count(itemstack:get_count()-1)
			user:get_inventory():add_item("main", "marssurvive:air_gassbotte")
			return itemstack
		end
	end,
})

local player_use_gassbottle = function(player, inv)
	local have_more=0
	for i=0,32,1 do
		if inv:get_stack("main", i):get_name()=="marssurvive:air_gassbotte" then
			local c=inv:get_stack("main", i):get_count()-1
			inv:set_stack("main", i,ItemStack({name="marssurvive:air_gassbotte",count=c}))
			inv:add_item("main", "marssurvive:air_gassbotte_empty")
			set_wear_sp(inv, 0)
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

--CRAFT
minetest.register_craft({
	output = "marssurvive:sp",
	recipe = {
		{"marssurvive:sp","marssurvive:air_gassbotte",""}

	},
})

minetest.register_craft({
	output = "marssurvive:spred",
	recipe = {
		{"","marssurvive:sp","",},
		{"marssurvive:unused2", "marssurvive:shieldblock", "marssurvive:unused2",},
		{"marssurvive:unused2", "marssurvive:shieldblock", "marssurvive:unused2"},

	},
})

minetest.register_craft({
	output = "marssurvive:spblue",
	recipe = {
		{"","marssurvive:spred","",},
		{"default:diamond", "default:diamondblock", "default:diamond",},
		{"default:diamond", "default:diamondblock", "default:diamond"},

	},
})

minetest.register_craft({
	output = "marssurvive:sp",
	recipe = {
		{"marssurvive:sp","marssurvive:air_gassbotte",""}

	},
})

minetest.register_craft({
	output = "marssurvive:air_gassbotte 2",
	recipe = {
		{"default:steel_ingot","marssurvive:oxogen","default:steel_ingot"},
	}
})

--FUNCTIONS

minetest.register_globalstep(function(dtime)
	marssurvive.breath_timer=marssurvive.breath_timer+dtime
	if marssurvive.breath_timer<2 then return end
	marssurvive.breath_timer=0
	for i, player in pairs(minetest.get_connected_players()) do
		local n=player:getpos()
		n=minetest.get_node({x=n.x,y=n.y+2,z=n.z}).name --why +2 and not +1???
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
					set_wear_sp(a, w)
				elseif a:get_stack("main", 1):get_wear()>=65533 then
					player_use_gassbottle(player, a)
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
		elseif ((not stack_one_sp(player:get_inventory()))
			or player:get_inventory():get_stack("main", 1):get_wear()>=65533)
			and n~="ignore" then
		        if n=="air" then								--(no spacesuit and in default air: lose 8 hp)
			player:set_hp(player:get_hp()-8)
		        elseif n~="marssurvive:air2" then						--(no spacesuit and inside something else: lose 1 hp)
			    player:set_hp(player:get_hp()-1)
			end
		end
	end
end)

--NEW (ARMOR)

minetest.register_on_player_hpchange(function(player, hp_change)
--  print("origional:"..hp_change)

	if hp_change < 0 then
	        local inv = player:get_inventory()
	        if stack_one_sp(inv) then
	                local sp = player_get_sp(inv)
		        hp_change = hp_change * (1/sp.heal)
            if hp_change > -1 then hp_change = -1 end --add by juli to keep hungry effect on special spacesuit
  --          print(hp_change)
	        end
	end
--  print(hp_change)
	return hp_change
end, true)


--[[
minetest.register_on_player_hpchange(function(player, hp_change)
   if hp_change < 0 then
           local inv = player:get_inventory()
           if stack_one_sp(inv) then
                   local sp = player_get_sp(inv)
              hp_change = hp_change * (1/sp.heal)
         print(hp_change)
         if hp_change > -1 then
            return -1
         end
           end
   end
   return hp_change
end, true)
--]]
