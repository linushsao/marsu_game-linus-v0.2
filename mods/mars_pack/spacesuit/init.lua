--NEW (for sp registration)

spacesuit = {breath_timer=0,skin={}}
spacesuit.registered_spacesuits = {}

--sp manipulation
local stack_one_sp = function(inventory)
        return string.sub(inventory:get_stack("main", 1):get_name(), 1, 12)=="spacesuit:sp"
end

local set_wear_sp = function(inventory, wear)
        local name = inventory:get_stack("main", 1):get_name()
        inventory:set_stack("main", 1,ItemStack({name=name,wear=wear}))
end

local player_get_sp = function(inventory)
        return spacesuit.registered_spacesuits[inventory:get_stack("main", 1):get_name()]
end
	
--skin
local player_attach_sp = function(player)
        local sp=player_get_sp(player:get_inventory())
        spacesuit.skin[player:get_player_name()]=player:get_properties().textures
	player:set_properties({visual = "mesh",textures = sp.textures, visual_size = {x=1, y=1}})
	--armor:
	player:set_armor_groups({fleshy = 100-sp.protection})
end

local player_deattach_sp = function(player)
	local textures = spacesuit.skin[player:get_player_name()]
        spacesuit.skin[player:get_player_name()]=nil
	player:set_properties({visual = "mesh",textures = textures, visual_size = {x=1, y=1}})
	--armor:
	player:set_armor_groups({fleshy = 100})
end



spacesuit.register_spacesuit = function(name, inventory_image, protection, textures)
        local tool_name = "spacesuit:sp" .. name
	spacesuit.registered_spacesuits[tool_name] = {sp_name=name, protection=protection, textures=textures}
	minetest.register_tool(tool_name, {
	        description = "Spacesuit " .. name .. " (wear slot 1)",
	        range = 4,
	        inventory_image = inventory_image,
        })
end

spacesuit.register_spacesuit("", "spacesuit_sp_white_inv.png", 0, {"spacesuit_sp_white.png"})
spacesuit.register_spacesuit("red", "spacesuit_sp_red_inv.png", 33, {"spacesuit_sp_red.png"})
spacesuit.register_spacesuit("blue", "spacesuit_sp_blue_inv.png", 66, {"spacesuit_sp_blue.png"})

--CRAFT

--GASSBOTTLE
minetest.register_node("spacesuit:air_gassbottle", {
	description = "Air gassbottle",
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

minetest.register_craftitem("spacesuit:air_gassbottle_empty", {
        description = "empty Air gassbotte",
        inventory_image = "gassbottle_empty.png",
    	on_place = function(itemstack, user, pointed_thing)
	        local node = minetest.get_node(pointed_thing.under)
	        if string.sub(node.name, 1, 14) == "marsair:airgen" then
		        itemstack:set_count(itemstack:get_count()-1)
			user:get_inventory():add_item("main", "spacesuit:air_gassbottle")
			return itemstack
		end
	end,
})

--CRAFT
minetest.register_craft({
	output = "spacesuit:sp",
	recipe = {
		{"spacesuit:sp","spacesuit:air_gassbottle",""}

	},
})

minetest.register_craft({
	output = "spacesuit:spred",
	recipe = {
		{"","spacesuit:sp","",},
		{"marssurvive:unused2", "marssurvive:shieldblock", "marssurvive:unused2",},
		{"marssurvive:unused2", "marssurvive:shieldblock", "marssurvive:unused2"},

	},
})

minetest.register_craft({
	output = "spacesuit:spblue",
	recipe = {
		{"","marssurvive:spred","",},
		{"default:diamond", "default:diamondblock", "default:diamond",},
		{"default:diamond", "default:diamondblock", "default:diamond"},

	},
})

minetest.register_craft({
	output = "spacesuit:air_gassbottle 2",
	recipe = {
		{"default:steel_ingot","marssurvive:oxogen","default:steel_ingot"},
	}
})

--FUNCTIONS
local damage = function(node, player)
	if node=="air" then								--(no spacesuit and in default air: lose 8 hp)
		player:set_hp(player:get_hp()-8)
	elseif node~="marsair:air_stable" then						--(no spacesuit and inside something else: lose 1 hp)
		player:set_hp(player:get_hp()-1)
	end
end

minetest.register_globalstep(function(dtime)
	spacesuit.breath_timer=spacesuit.breath_timer+dtime
	if spacesuit.breath_timer<2 then return end
	spacesuit.breath_timer=0
	for i, player in pairs(minetest.get_connected_players()) do
		local n=player:getpos()
		n=minetest.get_node({x=n.x,y=n.y+1,z=n.z}).name
		local inv=player:get_inventory()
		
		if stack_one_sp(inv) then
			local wear = inv:get_stack("main", 1):get_wear()
			if n == "marsair:air_stable" then
				if wear < 65533 then
					local new_wear = wear-(65534/20)
					if new_wear < 0 then new_wear = 0 end
					set_wear_sp(inv, new_wear)
				end
			else
				if wear < 65533 then
					local new_wear=wear+ (65534/900)
					if new_wear >= 65533 then new_wear = 65533 end
					set_wear_sp(inv, new_wear)
					player:set_breath(11)
				else
					local bottle = {name="spacesuit:air_gassbottle", count=1, wear=0, metadata=""}
					print('bottle', inv:contains_item("main", bottle))
					if inv:contains_item("main", bottle) then
						local removed = inv:remove_item("main", bottle)
						set_wear_sp(inv, 0)
						removed:set_name(removed:get_name() .. "_empty")
						inv:add_item("main", removed)
						minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,})
						
						if inv:contains_item("main", bottle) then --have one or more bottles 
							minetest.chat_send_player(player:get_player_name(), "Warning: one more air-gassbottle is empty!")		
						else
							minetest.chat_send_player(player:get_player_name(), "Warning: have none air-gassbottle left!")
						end
					else
						--no bottle, no wear 
						damage(n, player)
					end
				end
			end
			--skin:
			if (spacesuit.skin[player:get_player_name()] == nil) then
				player_attach_sp(player)
			end
		else
			if (spacesuit.skin[player:get_player_name()] ~= nil) then
				player_deattach_sp(player)
			end
			damage(n, player)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	if stack_one_sp(player:get_inventory()) then
		player_attach_sp(player)
	end
end)

-- clear player data
minetest.register_on_leaveplayer(function(player)
	spacesuit.skin[player:get_player_name()]=nil
end)

--BACKWARDS COMPATIBLITY
minetest.register_alias("marssurvive:air_gassbotte","spacesuit:air_gassbottle")
minetest.register_alias("marssurvive:air_gassbotte_empty","spacesuit:air_gassbottle_empty")
minetest.register_alias("marssurvive:sp","spacesuit:sp")
minetest.register_alias("marssurvive:spred", "spacesuit:spred")
minetest.register_alias("marssurvive:spblue", "spacesuit:spblue")


--for test
minetest.register_on_player_hpchange(function(player, hp_change)
	print("\n\nHP_CHANGE: " .. hp_change)
	print(dump(player:get_armor_groups()))
	return hp_change
end, true)


print("[MOD] Spacesuit loaded!")
