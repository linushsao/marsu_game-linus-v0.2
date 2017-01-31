--Created by Krock for the BitChange mod
--License: WTFPL

moneychanger = {}
moneychanger.constructing = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",  "size[8,7]" ..
				"list[current_name;source;0,1;1,1;]" ..
				"label[0,0;Input money]" ..
				"list[current_name;output;2,1;2,1;]" ..
				"label[2,0;Possible converts]" ..
				"list[current_name;rest;5,1;1,1;]" ..
				"label[5,0;Remaining money]" ..
				"list[current_player;main;0,3;8,4;]")
end
moneychanger.update_fields = function(pos, listname, index, stack, take)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack_inv = inv:get_stack(listname, index)
	local stack_rest = inv:get_stack("rest", 1)
	local stack_name = stack:get_name()
	local stack_src = inv:get_stack("source", 1)
	local stack_src_name = stack_src:get_name()
	local stack_real_count = 0
	local canMove = false
	if(take) then
		stack_real_count = stack_inv:get_count() - stack:get_count()
	else
		if(stack_inv:get_name() ~= "") then
			stack_real_count = stack_inv:get_count() + stack:get_count()
		else
			stack_real_count = stack:get_count()
		end
	end
	
	if(listname == "source" and (stack_rest:get_count() == 0 or take)) then
		inv:set_list("output",  { "", "" })
		if(stack_real_count > 0) then
			if(stack_name == "bitchange:minecoinblock") then
				inv:set_list("output", { "bitchange:minecoin "..(stack_real_count*9), "" })
			elseif(stack_name == "bitchange:minecoin") then
				inv:set_list("output", { "bitchange:mineninth "..math.min(stack_real_count*9, 30000), "bitchange:minecoinblock "..math.floor(stack_real_count/9) })
			else
				inv:set_list("output", { "bitchange:minecoin "..math.min(math.floor(stack_real_count/9), 30000), "" })
			end
			canMove = true
		elseif(stack_real_count == 0 and stack_src:get_count() > 0) then
			canMove = true
		end
	elseif(listname == "output" and stack_rest:get_count() == 0) then
		if(stack_src:get_count() < 1) then
			if(stack:get_count() > 0) then
				canMove = true
			end
			inv:set_list("source",  { "" })
		else
			if(stack_src_name ~= "") then
				if(stack_name == "bitchange:minecoinblock" and stack_src_name == "bitchange:minecoin") then
					local amount_left = (stack_src:get_count() - (stack:get_count()*9))
					if(amount_left > 0) then
						inv:set_list("source", { stack_src_name.." "..amount_left })
					else
						inv:set_list("source", { "" })
					end
					if(index == 1) then
						inv:set_stack("output", 2, "")
					else
						inv:set_stack("output", 1, "")
					end
					canMove = true
				elseif(stack_name == "bitchange:minecoin" and stack_src_name == "bitchange:mineninth") then
					local amount_left = (stack_src:get_count() - (stack:get_count()*9))
					if(amount_left > 0) then
						inv:set_list("source", { stack_src_name.." "..amount_left })
					else
						inv:set_list("source", { "" })
					end
					canMove = true
				elseif(stack_name == "bitchange:minecoin" and stack_src_name == "bitchange:minecoinblock") then
					local amount_left = stack_src:get_count() - (stack:get_count()/9)
					local rest_count = (amount_left - math.floor(amount_left))*9
					if(amount_left > -1) then
						inv:set_list("source", { stack_src_name.." "..math.floor(amount_left) })
						if(rest_count > 0) then
							inv:set_list("rest", { stack_name.." "..rest_count })
						else
							inv:set_list("rest", { "" })
						end
						if(index == 1) then
							inv:set_stack("output", 2, "")
						else
							inv:set_stack("output", 1, "")
						end
						inv:set_stack("output", index, stack_name.." "..stack:get_count())
						canMove = true
					end
				elseif(stack_name == "bitchange:mineninth" and stack_src_name == "bitchange:minecoin") then
					local amount_left = stack_src:get_count() - (stack:get_count()/9)
					local rest_count = (amount_left - math.floor(amount_left))*9
					if(amount_left > -1) then
						inv:set_list("source", { stack_src_name.." "..math.floor(amount_left) })
						if(rest_count > 0) then
							inv:set_list("rest", { stack_name.." "..rest_count })
						else
							inv:set_list("rest", { "" })
						end
						if(index == 1) then
							inv:set_stack("output", 2, "")
						else
							inv:set_stack("output", 1, "")
						end
						inv:set_stack("output", index, stack_name.." "..stack:get_count())
						canMove = true
					end
				end
			end
		end
	elseif(listname == "rest") then
		canMove = true
	end
	if(canMove) then
		return stack:get_count() 
	else
		return 0
	end
end

minetest.register_node("bitchange:moneychanger", {
	description = "Moneychanger",
	tiles = {"bitchange_moneychanger_top.png", "bitchange_moneychanger_top.png", "bitchange_moneychanger_side.png",
		"bitchange_moneychanger_side.png", "bitchange_moneychanger_top.png", "bitchange_moneychanger_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		return moneychanger.constructing(pos);
	end,
	after_place_node = function(pos, placer, itemstack)
		local owner = placer:get_player_name()
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Moneychanger (owned by "..owner..")")
		meta:set_string("owner",owner)
		local inv = meta:get_inventory()
		inv:set_size("source", 1)
		inv:set_size("rest", 1)
		inv:set_size("output", 2)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if(player:get_player_name() ~= meta:get_string("owner")) then
			return 0
		end
		if(listname == "source") then
			local stack_name = stack:get_name()
			if(stack_name == "bitchange:mineninth" or stack_name == "bitchange:minecoin" or stack_name == "bitchange:minecoinblock") then
				return moneychanger.update_fields(pos, listname, index, stack, false)
			else
				return 0
			end
		else
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if(player:get_player_name() == meta:get_string("owner") or minetest.get_player_privs(name)["server"]) then
			return moneychanger.update_fields(pos, listname, index, stack, true)
		else
			return 0
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if(player:get_player_name() ~= meta:get_string("owner") and not minetest.get_player_privs(name)["server"]) then
			return 0
		end
		return inv:is_empty("source") and inv:is_empty("output") and inv:is_empty("rest")
	end
})

minetest.register_craft({
	output = 'bitchange:moneychanger',
	recipe = {
		{'default:stone', 'bitchange:mineninth', 'default:stone'},
		{'default:steel_ingot', 'bitchange:minecoin', 'default:steel_ingot'},
		{'default:stone', 'default:stone', 'default:stone'}
	}
})