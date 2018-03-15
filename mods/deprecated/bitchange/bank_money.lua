--Created by Krock for the BitChange mod
--	Bank node for the mod: money (by kotolegokot)
--License: WTFPL

local file_path = minetest.get_worldpath() .. "/bitchange_bank_money"
local exchange_worth = 100.0 -- default worth in "money" for one MineCoin, change if not okay
local bank = {}
local changes_made = false

local fs_1 = io.open(file_path, "r")
if fs_1 then
	exchange_worth = tonumber(fs_1:read("*l"))
	io.close(fs_1)
end

local function round(num, idp)
	if idp and idp>0 then
		local mult = 10^idp
		return math.floor(num * mult + 0.5) / mult
	end
	return math.floor(num + 0.5)
end

local function save_exchange_rate()
	local fs_2 = io.open(file_path, "w")
	fs_2:write(tostring(exchange_worth))
	io.close(fs_2)
end

local ttime = 0
minetest.register_globalstep(function(t)
        ttime = ttime + t
        if ttime < 240 then --every 4min'
                return
        end
		if(changes_made) then
			save_exchange_rate()
		end
		ttime = 0
end)

minetest.register_on_shutdown(function() 
	save_exchange_rate()
end)

local function has_bank_privilege(meta, player)
	local player_name = player:get_player_name()
	return ((player_name == meta:get_string("owner")) or minetest.get_player_privs(player_name).server)
end

local function get_bank_formspec(number, pos)
	local formspec = ""
	local name = "nodemeta:"..pos.x..","..pos.y..","..pos.z
	if(number == 1) then
		-- customer
		formspec = ("size[8,8]"..
				"label[0,0;Bank]"..
				"label[2,0;(View reserve with (E) + (Right click))]"..
				"label[1,1;Current worth of a MineCoin:]"..
				"label[3,1.5;~ "..round(exchange_worth, 4).." money]"..
				"button[2,3;3,1;sell10;Buy 10 MineCoins]"..
				"button[2,2;3,1;buy10;Sell 10 MineCoins]"..
				"list[current_player;main;0,4;8,4;]")
	elseif(number == 2) then
		-- owner
		formspec = ("size[8,9;]"..
				"label[0,0;Bank]"..
				"label[1,0.5;Current MineCoin reserve: (Editable by owner)]"..
				"list["..name..";coins;0,1;8,3;]"..
				"list[current_player;main;0,5;8,4;]")
	end
	return formspec
end

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if(formname == "bitchange:bank_formspec") then
		local player_name = sender:get_player_name()
		if(fields.quit)  then
			bank[player_name] = nil
			return
		end
		if(exchange_worth < 1) then
			exchange_worth = 1
		end
		local pos = bank[player_name]
		local bank_inv = minetest.get_meta(pos):get_inventory()
		local player_inv = sender:get_inventory()
		local coin_stack = "bitchange:minecoin 10"
		local err_msg = ""
		if(fields.buy10) then
			if(not player_inv:contains_item("main", coin_stack)) then
				err_msg = "You do not have the needed MineCoins."
			end
			if(err_msg == "") then
				if(not bank_inv:room_for_item("coins", coin_stack)) then
					err_msg = "This bank has no space to buy more MineCoins."
				end
			end
			if(err_msg == "") then
				exchange_worth = exchange_worth * 0.995
				local price = round(exchange_worth - 0.1, 1) * 10
				local cur_money = money.get_money(player_name)
				money.set_money(player_name, cur_money + price)
				player_inv:remove_item("main", coin_stack)
				bank_inv:add_item("coins", coin_stack)
				changes_made = true
				err_msg = "Sold 10 MineCoins for "..price.." money"
			end
		elseif(fields.sell10) then
			local price = round(exchange_worth, 1) * 10
			local cur_money = money.get_money(player_name)
			if(cur_money < price) then
				err_msg = "You do not have the required money. ("..price.." money)"
			end
			if(err_msg == "") then
				if(not bank_inv:contains_item("coins", coin_stack)) then
					err_msg = "This bank has no MineCoins ready to sell."
				end
			end
			if(err_msg == "") then
				if(not player_inv:room_for_item("main", coin_stack)) then
					err_msg = "You do not have enough space in your inventory."
				end
			end
			if(err_msg == "") then
				money.set_money(player_name, cur_money - price)
				bank_inv:remove_item("coins", coin_stack)
				player_inv:add_item("main", coin_stack)
				exchange_worth = exchange_worth * 1.005
				changes_made = true
				err_msg = "Bought 10 MineCoins for "..price.." money"
			end
		end
		if(err_msg ~= "") then
			minetest.chat_send_player(player_name, "Bank: "..err_msg)
		end
	end
end)

minetest.register_node("bitchange:bank", {
	description = "Bank",
	tiles = {"bitchange_bank_side.png", "bitchange_bank_side.png",
			 "bitchange_bank_side.png", "bitchange_bank_side.png",
			 "bitchange_bank_side.png", "bitchange_bank_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=1,level=1},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Bank (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Bank (constructing)")
		meta:set_string("formspec", "")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("coins", 8*3)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		if(meta:get_string("owner") == player:get_player_name()) then
			return meta:get_inventory():is_empty("coins")
		else
			return false
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local player_name = clicker:get_player_name()
		local view = 1
		bank[player_name] = pos
		if(clicker:get_player_control().aux1) then
			view = 2
		end
		minetest.show_formspec(player_name,"bitchange:bank_formspec",get_bank_formspec(view, pos))
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if(has_bank_privilege(meta, player)) then
			return count
		end
		return 0
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if (has_bank_privilege(meta, player)) then
			return stack:get_count()
		end
		return 0
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if (has_bank_privilege(meta, player)) then
			return stack:get_count()
		end
		return 0
	end,
})