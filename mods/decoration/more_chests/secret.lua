local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

local open =  "size[8,10]"..
	"list[current_name;main;0,0;8,4;]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"button[3,9;2,1;open;close]"
local closed = "size[2,1]"..
	"button[0,0;2,1;open;open]"

minetest.register_node("more_chests:secret", {
	description = "Secret Chest",
	tiles = {"secret_top.png", "secret_top.png", "secret_side.png",
		"secret_side.png", "secret_side.png", "secret_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2, tubedevice = 1, tubedevice_receiver = 1},
-- Pipeworks
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Secret Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", open)
		meta:set_string("infotext", "Secret Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a secret chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a secret chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a secret chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in secret chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to secret chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from secret chest at "..minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		if has_locked_chest_privilege(meta, sender) then
			if fields.open == "open" then
				meta:set_string("formspec", open)
			else
				meta:set_string("formspec", closed)
			end
		end
	end,
})

minetest.register_craft({
	output = 'more_chests:secret',
	recipe = {
		{'default:wood','default:cobble','default:wood'},
		{'default:wood','default:steel_ingot','default:wood'},
		{'default:wood','default:wood','default:wood'}
	}
})
minetest.register_craft({
	output = 'more_chests:secret',
	recipe = {
		{'marssurvive:wood','default:cobble','marssurvive:wood'},
		{'marssurvive:wood','default:steel_ingot','marssurvive:wood'},
		{'marssurvive:wood','marssurvive:wood','marssurvive:wood'}
	}
})
