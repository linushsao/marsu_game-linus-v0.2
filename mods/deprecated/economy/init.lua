--MONEY!!!
-- ŧ
if false then --for test disable mod
economy={}

economy.itemprices_pr={
	["default:coal_lump"]=5,
	["currency:minegeld"]=1,
	["marssurvive:oxogen"]=20,
	["default:clay_lump"]=10,
	["farming:bread"]=5,
	["default:apple"]=5,
--	["animalmaterials:fur"]=30,
--	["mobs:leather"]=30,
--	["animalmaterials:fur_deer"]=30,
	["bucket:bucket_empty"]=120,
--
--	["default:iron_lump"]=100,
--	["default:copper_lump"]=200,
	["default:gold_lump"]=600,
	["default:diamond"]=1000,
	["moreores:mithril_lump"]=200,
	["moreores:silver_lump"]=200,
	["moreores:tin_lump"]=200,

	["default:mese_crystal_fragment"]=200,
}
economy.mobkillrewards={
	["creatures:zombie"]=10,
	["creatures:ghost"]=10,
	["creatures:oerrki"]=10,
	--[[
	["mobs:sand_monster"]=10,
	["mobs:stone_monster"]=100,
	["mobs:kitten"]=20,
	["mobs:cow"]=30,
	["mobs:mese_monster"]=200,
	["mobs:dungeonmaster"]=2500,
	["mobs:oerkki"]=350,
	--]]
}

economy.itemprices={}
minetest.after(0, function()
	for k,v in pairs(economy.itemprices_pr) do
		if not minetest.registered_items[k] then
			print("[economy]unknown item in prices list: "..k)
		else
			economy.itemprices[k]=v
		end
	end
end)

economy.balance={}
economy.accountlog={}

--[[
	save version history:
	{balance=economy.balance, accountlog=economy.accountlog, version=1}
]]

economy.fpath=minetest.get_worldpath().."/economy"
local file, err = io.open(economy.fpath, "r")
if not file then
	economy.balance = economy.balance or {}
	local er=err or "Unknown Error"
	print("[economy]Failed loading economy save file "..er)
else
	local deserialize=minetest.deserialize(file:read("*a"))
	economy.balance = deserialize.balance or deserialize
	economy.accountlog = deserialize.accountlog or {}
	if type(economy.balance) ~= "table" then
		economy.balance={}
	end
	if type(economy.accountlog) ~= "table" then
		economy.balance={}
	end
	file:close()
end


economy.save = function()
local datastr = minetest.serialize({balance=economy.balance, accountlog=economy.accountlog, version=1})
if not datastr then
	minetest.log("error", "[economy] Failed to serialize balance data!")
	return
end
local file, err = io.open(economy.fpath, "w")
if err then
	return err
end
file:write(datastr)
file:close()
end

--economy globalstep
economy.save_cntdn=10
minetest.register_globalstep(function(dtime)
	if economy.save_cntdn<=0 then
		economy.save()
		economy.save_cntdn=10 --10 seconds interval!
	end
	economy.save_cntdn=economy.save_cntdn-dtime
end)

local svm_cbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
}

minetest.register_node("economy:vending", {
	drawtype = "mesh",
	description = "Vending Machine",

	mesh = "economy_vending.obj",
	tiles = {"economy_vending.png"},
	groups = {snappy=3},
	selection_box = svm_cbox,
	collision_box = svm_cbox,

	inventory_image = "economy_vending_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	on_rightclick = function(pos, node, clicker, itemstack)
		economy.open_vending(pos, clicker)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
			minetest.chat_send_player( placer:get_player_name(), "Not enough vertical space to place a vending machine!" )
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		if meta then
			meta:set_string("infotext", "Vending Machine.")
			local inv=meta:get_inventory()
			inv:set_size("main", 0)
			inv:set_size("sell", 1)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname=="sell" then
			if economy.itemprices[stack:get_name()] then
				return stack:get_count()
			else
				economy.formspecs.vendingsell.open(player, pos, true)
			end
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return 0
	end,
	allow_metadata_inventory_move = function(pos, listname, index, stack, player)
		return 0
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname=="sell" then
			local priceper=economy.itemprices[stack:get_name()]
			economy.deposit(player, priceper*stack:get_count(), "Sold "..stack:get_count().." "..(minetest.registered_items[stack:get_name()] and minetest.registered_items[stack:get_name()].description.." ("..stack:get_name()..")" or stack:get_name()))

			local meta=minetest.get_meta(pos)
			local inv=meta:get_inventory()
			if meta:get_int(stack:get_name()) then
				local i=meta:get_int(stack:get_name())
				i=i+stack:get_count()
				meta:set_int(stack:get_name(), i)
			end

			inv:set_stack("sell", 1, "ignore 0")
			economy.formspecs.vendingsell.open(player, pos)
		end
	end
})
minetest.register_node("economy:bank", {
	drawtype = "mesh",
	description = "Banking Machine",

	mesh = "economy_vending.obj",
	tiles = {"economy_bank.png"},
	groups = {snappy=3},
	selection_box = svm_cbox,
	collision_box = svm_cbox,

	inventory_image = "economy_bank_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	on_rightclick = function(pos, node, clicker, itemstack)
		economy.open_bank(pos, clicker)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
			minetest.chat_send_player( placer:get_player_name(), "Not enough vertical space to place a bank machine!" )
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		if meta then
			meta:set_string("infotext", "Banking Machine.")
		end
	end,
})
minetest.register_node("economy:playervendor", {
	drawtype = "mesh",
	description = "Vending Machine (to be set up by players)",

	mesh = "economy_vending.obj",
	tiles = {"economy_playervendor.png"},
	selection_box = svm_cbox,
	collision_box = svm_cbox,

	inventory_image = "economy_playervendor_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	on_rightclick = function(pos, node, clicker, itemstack)
		economy.open_playervendor(pos, clicker)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
			minetest.chat_send_player( placer:get_player_name(), "Not enough space upwards!" )
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		if meta then
			meta:set_string("infotext", "Vending Machine of "..placer:get_player_name())
			meta:set_string("owner", placer:get_player_name())
			local inv=meta:get_inventory()
			inv:set_size("main", 0)
			inv:set_size("sell", 1)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname=="sell" then
			return stack:get_count()
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return 0
	end,
	allow_metadata_inventory_move = function(pos, listname, index, stack, player)
		return 0
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname=="sell" then
			local meta=minetest.get_meta(pos)
			local inv=meta:get_inventory()
			local i=meta:get_int("ic_"..stack:get_name())
			i=i+stack:get_count()
			meta:set_int("ic_"..stack:get_name(), i)

			if meta:get_int("ip_"..stack:get_name())==0 then
				meta:set_int("ip_"..stack:get_name(),economy.itemprices[stack:get_name()] or 100)
			end
			inv:set_stack("sell", 1, "ignore 0")
			economy.formspecs.pvendinginput.open(player, pos)
		end
	end
})
economy.pname=function(player_or_name)
	if player_or_name then
		if type(player_or_name)=="userdata" and player_or_name.get_player_name then
			return player_or_name:get_player_name()
		end
	end
	return player_or_name
end
economy.deposit=function(player, amount, reason)
	local pname=economy.pname(player)
	if not economy.balance[pname] then
		economy.balance[pname]=0
	end
	economy.balance[pname]=economy.balance[pname]+amount
	if not economy.accountlog[pname] then
		economy.accountlog[pname]={}
	end
	table.insert(economy.accountlog[pname], 1, {action=reason or "Unknown deposit", amount="+ "..amount})
end
economy.moneyof=function(player)
	local pname=economy.pname(player)
	if not economy.balance[pname] then
		economy.balance[pname]=0
	end
	return economy.balance[pname]
end
economy.canpay=function(player, amount)
	local pname=economy.pname(player)
	if not economy.balance[pname] then
		economy.balance[pname]=0
	end
	return economy.balance[pname]>=amount
end
economy.buyprice=function(sellprice)
	local discount=1
--	return math.ceil(sellprice*1.2)
	return math.ceil(sellprice*discount)

end
economy.withdraw=function(player, amount, reason)
	local pname=economy.pname(player)
	if not economy.balance[pname] then
		economy.balance[pname]=0
	end
	if not economy.canpay(player, amount) then
		return false
	end
	economy.balance[pname]=economy.balance[pname]-amount
	if not economy.accountlog[pname] then
		economy.accountlog[pname]={}
	end
	table.insert(economy.accountlog[pname], 1, {action=reason or "Unknown withdrawal", amount="- "..amount})
	return true
end
economy.itemdesc=function(iname)
	return minetest.registered_items[iname] and minetest.registered_items[iname].description or iname
end
economy.itemdesc_ext=function(iname)
	return minetest.registered_items[iname] and minetest.registered_items[iname].description.." ("..iname..")" or iname
end

economy.formspecs={

	vendingsell={
		open=function(player, pos, cantsell)
			minetest.show_formspec(economy.pname(player), "economy_vendingsell_"..minetest.pos_to_string(pos), [[
				size[8,8]
				label[0,0;Your balance: ]]..economy.moneyof(player:get_player_name())..[[ ŧ]
				button[1,1;3,1;buy;Buy items / Price list]
				list[nodemeta:]]..pos.x..","..pos.y..","..pos.z..[[;sell;2,2;1,1;]
				]]..(cantsell and "label[1,3;You can't sell this item. Please see price list!]" or "label[1,3;Put items here to sell them.]")..[[
				list[current_player;main;0,4;8,4;]
				]])
		end,
		hdlr=function(player, restformname, fields)
			if fields.buy then
				local pos=minetest.string_to_pos(restformname)
				economy.formspecs.vendingbuy.open(player, pos)
			end
		end
	},
	vendingbuy={
		open=function(player, pos, page, shownoavailable)
			page=tonumber(page)
			if not page then
				page=1
			end
			local meta=minetest.get_meta(pos)
			if not meta then return end

			local idsp={}
			for k,v in pairs(economy.itemprices) do
				if meta:get_int(k)>0 then
					table.insert(idsp,1,{name=k, price=v, count=meta:get_int(k)})
				else
					table.insert(idsp,{name=k, price=v, count=0})
				end
			end
			local totalPages=math.ceil(#idsp/10)
			if page<1 then page=1 end
			if page>totalPages then page=totalPages end

			local formspec="size[8,8]button[1,6.5;3,1;sell;Sell items]label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ]"

			if page~=1 then formspec=formspec.."button[5,6.5;1,1;page_"..(page-1)..";<<]" end
			if page~=totalPages then formspec=formspec.."button[6,6.5;1,1;page_"..(page+1)..";>>]" end


			for i=page*10-9,page*10 do
				if idsp[i] then
					if idsp[i].count>0 then
						--formspec=formspec.."item_image_button[1,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"
						--.."label[2,"..(((i-1)%10)*0.5+1)..";Verkauf "..idsp[i].price.." ŧ / Kauf "..economy.buyprice(idsp[i].price).." ŧ ("..idsp[i].count.." verfügbar)]"
						formspec=formspec.."item_image_button[0,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"..
						"label[0.5,"..(((i-1)%10)*0.5+1)..";("..idsp[i].count..") "..economy.itemdesc(idsp[i].name).."]"..
						"label[4,"..(((i-1)%10)*0.5+1)..";Buy "..economy.buyprice(idsp[i].price).." ŧ / Sell "..idsp[i].price.." ŧ]"
					else
						--formspec=formspec.."item_image_button[1,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";noavail_"..(page)..";]"
						--.."label[2,"..(((i-1)%10)*0.5+1)..";Verkauf "..idsp[i].price.." ŧ / Kauf "..economy.buyprice(idsp[i].price).." ŧ (nicht verfügbar)]"
						formspec=formspec.."item_image_button[0,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";noavail_"..(page)..";X]"..
						"label[0.5,"..(((i-1)%10)*0.5+1)..";(-) "..economy.itemdesc(idsp[i].name).."]"..
						"label[4,"..(((i-1)%10)*0.5+1)..";Sell "..idsp[i].price.." ŧ ]"

					end
				end
			end
			if shownoavailable then
				formspec=formspec.."label[0,7.5;The selected item is not available at this machine!]"
			end

			minetest.show_formspec(economy.pname(player), "economy_vendingbuy_"..minetest.pos_to_string(pos), formspec)
		end,
		hdlr=function(player, restformname, fields)
			if fields.sell then
				local pos=minetest.string_to_pos(restformname)
				economy.formspecs.vendingsell.open(player, pos)
			elseif not fields.quit then
				local pos=minetest.string_to_pos(restformname)
				for k,_ in pairs(fields) do
					local d=string.match(k, "^buy_(.+)$")
					if d then
						economy.formspecs.vendingbuyitem.open(player, pos, d)
					end
					d=string.match(k, "^page_(%d+)$")
					if d then
						economy.formspecs.vendingbuy.open(player, pos, d)
						return
					end
					d=string.match(k, "^noavail_(%d+)$")
					if d then
						economy.formspecs.vendingbuy.open(player, pos, d, true)
						return
					end
				end
			end
		end
	},
	vendingbuyitem={
		open=function(player, pos, iname, buying, cantafford, toomanyitems)

			local meta=minetest.get_meta(pos)
			if not meta then return end
			local available=meta:get_int(iname)
			if available<1 then return end

			if not minetest.registered_items[iname] then return end

			local maxcount=math.min(minetest.registered_items[iname].stack_max, available)
			local buyprice=economy.buyprice(economy.itemprices[iname])

			local buyingstr=""
			if cantafford then
				buyingstr="label[0,5;Insufficient funds!]"
			elseif toomanyitems then
					buyingstr="label[0,5;Inventory full!]"
			elseif buying then
				if buying>maxcount then
					buyingstr="label[0,5;This amount is greater than the maximum.]"
				elseif buying<1 then
					buyingstr="label[0,5;Less than one item can't be bought.]"
				else
					buyingstr="label[0,5;"..buying.." items cost "..buying*buyprice.." ŧ]"
				end
			end

			minetest.show_formspec(economy.pname(player), "economy_vendingbuyitem_"..minetest.pos_to_string(pos).."_"..iname,
			"size[8,8]item_image[5,1;2,2;"..iname.."]"..
				"label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ]"..
				"label[0,1;You are buying "..(minetest.registered_items[iname].description or "<unknown>").." ("..iname..")]"..
				"label[0,2;Price per item: "..buyprice.." ŧ]"..
				"label[0,3;There are "..available.." items available.]"..
				"label[0,4;You can buy a maximum of "..maxcount.." items in one step.]"..
				buyingstr..
				"field[0.5,6.4;1.5,1;icnt;Count;"..(buying or maxcount).."]button[2,6;3,1;spr;Show price]button[5,6;3,1;buy;Buy!]button[2,7;3,1;back;Back]"


			)
		end,
		hdlr=function(player, restformname, fields)
			local posstr, iname=string.match(restformname, "^([^_]+)_(.+)$")
			--print(restformname)
			local pos=posstr and minetest.string_to_pos(posstr)
			if fields.spr then
				economy.formspecs.vendingbuyitem.open(player, pos, iname, tonumber(fields.icnt))
			elseif fields.back then
				economy.formspecs.vendingbuy.open(player, pos, 1)
			elseif fields.buy then
				local tobuy=tonumber(fields.icnt)
				if not tobuy then
					economy.formspecs.vendingbuyitem.open(player, pos, iname)
					return
				end

				local meta=minetest.get_meta(pos)
				if not meta then return end
				local available=meta:get_int(iname)
				if available<1 then
					economy.formspecs.vendingbuy.open(player, pos, 1)
				end

				if not minetest.registered_items[iname] then return end

				local maxcount=math.min(minetest.registered_items[iname].stack_max, available)
				local buyprice=economy.buyprice(economy.itemprices[iname])

				if tobuy>maxcount or tobuy<1 then
					economy.formspecs.vendingbuyitem.open(player, pos, iname, tobuy)
					return
				end
				local totalprice=tobuy*buyprice
				if economy.canpay(player, totalprice) then
					local inv=player:get_inventory()
					local stack=ItemStack(iname.." "..tobuy)
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
						meta:set_int(iname, available-tobuy)
						economy.withdraw(player, totalprice, "Buying "..tobuy.." "..(minetest.registered_items[iname] and minetest.registered_items[iname].description.." ("..iname..")" or iname))
						economy.formspecs.vendingbuy.open(player, pos, 1)
					else
						economy.formspecs.vendingbuyitem.open(player, pos, iname, tobuy, false, true)
					end
				else
					economy.formspecs.vendingbuyitem.open(player, pos, iname, tobuy, true)
					return
				end

			end

		end
	},
	pvendingown={
		open=function(player, pos, page, shownoavailable)
			page=tonumber(page)
			if not page then
				page=1
			end
			local meta=minetest.get_meta(pos)
			if not meta then return end
			if not meta:get_string("owner")==economy.pname(player) then return end

			local idsp={}
			local inametbl={}
			local metatable=meta:to_table().fields
			for k,v in pairs(metatable) do
				-- c:count, p: price
				-- format: i[c/p]_iname
				local what,iname=string.match(k, "^i([cp])_(.+)$")
				if what and iname then
					if not inametbl[iname] then inametbl[iname]={} end
					inametbl[iname][what]=meta:get_int("i"..what.."_"..iname)
				end
			end
			for k,v in pairs(inametbl) do
				if v.p and v.c and v.c>0 then
					table.insert(idsp,1,{name=k, price=v.p, count=v.c})
				end
			end

			local totalPages=math.ceil(#idsp/10)
			if page<1 then page=1 end
			if page>totalPages then page=totalPages end

			local formspec="size[9,8]button[0,6.5;5,1;sell;Add items to sell]label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ. This machine sells::]"

			if #idsp==0 then
				formspec=formspec.."label[0,2;This machine has nothing to sell at the moment..]"
			end

			if page~=1 then formspec=formspec.."button[5,6.5;1,1;page_"..(page-1)..";<<]" end
			if page~=totalPages then formspec=formspec.."button[6,6.5;1,1;page_"..(page+1)..";>>]" end


			for i=page*10-9,page*10 do
				if idsp[i] then
					if idsp[i].count>0 then
						--formspec=formspec.."item_image_button[1,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"
						--.."label[2,"..(((i-1)%10)*0.5+1)..";Verkauf "..idsp[i].price.." ŧ / Kauf "..economy.buyprice(idsp[i].price).." ŧ ("..idsp[i].count.." verfügbar)]"
						formspec=formspec.."item_image_button[0,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"..
						"label[0.5,"..(((i-1)%10)*0.5+1)..";("..idsp[i].count..") "..economy.itemdesc(idsp[i].name).."]"..
						"label[4,"..(((i-1)%10)*0.5+1)..";Price: "..idsp[i].price.." ŧ]"..
						"button[6,"..(((i-1)%10)*0.5+1)..";3,0.6;chpr_"..idsp[i].name..";Change price]"
					end
				end
			end
			formspec=formspec.."label[0,7.5;Click the symbol to take items back.]"

			minetest.show_formspec(economy.pname(player), "economy_pvendingown_"..minetest.pos_to_string(pos), formspec)
		end,
		hdlr=function(player, restformname, fields)
			if fields.sell then
				local pos=minetest.string_to_pos(restformname)
				economy.formspecs.pvendinginput.open(player, pos)
			elseif not fields.quit then
				local pos=minetest.string_to_pos(restformname)
				for k,_ in pairs(fields) do
					local d=string.match(k, "^buy_(.+)$")
					if d then
						economy.formspecs.pvendingitemtakeout.open(player, pos, d)
					end
					local d=string.match(k, "^chpr_(.+)$")
					if d then
						economy.formspecs.pvendingitemchpr.open(player, pos, d)
					end
					d=string.match(k, "^page_(%d+)$")
					if d then
						economy.formspecs.pvendingown.open(player, pos, d)
						return
					end
				end
			end
		end
	},
	pvendingitemchpr={
		open=function(player, pos, iname)
			local meta=minetest.get_meta(pos)
			if not meta then return end
			if not meta:get_string("owner")==economy.pname(player) then return end

			local price=meta:get_int("ip_"..iname)

			minetest.show_formspec(economy.pname(player), "economy_pvendingitemchpr_"..minetest.pos_to_string(pos).."_"..iname,
				"field[newprice;new price for "..economy.itemdesc(iname)..":;"..(price or "").."]"
			)
		end,
		hdlr=function(player, restformname, fields)
			local posstr, iname=string.match(restformname, "^([^_]+)_(.+)$")
			--print(restformname)
			local pos=posstr and minetest.string_to_pos(posstr)
			if tonumber(fields.newprice) and tonumber(fields.newprice)>0 then
				local meta=minetest.get_meta(pos)
				if not meta then return end
				if not meta:get_string("owner")==economy.pname(player) then return end
				meta:set_int("ip_"..iname, tonumber(fields.newprice))
				economy.formspecs.pvendingown.open(player, pos)
			end
		end
	},
	pvendingitemtakeout={
		open=function(player, pos, iname, buying, toomanyitems)

			local meta=minetest.get_meta(pos)
			if not meta then return end
			if not meta:get_string("owner")==economy.pname(player) then return end
			local available=meta:get_int("ic_"..iname)
			if available<1 then return end

			if not minetest.registered_items[iname] then return end

			local maxcount=math.min(minetest.registered_items[iname].stack_max, available)

			local buyingstr=""
			if toomanyitems then
				buyingstr="label[0,5;Inventory full!]"
			elseif buying then
				if buying>maxcount then
					buyingstr="label[0,5;This amount is greater than the maximum.]"
				elseif buying<1 then
					buyingstr="label[0,5;You can't buy less than 1 item.]"
				end
			end

			minetest.show_formspec(economy.pname(player), "economy_pvendingitemtakeout_"..minetest.pos_to_string(pos).."_"..iname,
			"size[8,8]item_image[5,1;2,2;"..iname.."]"..
			"label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ]"..
			"label[0,1;You take "..(minetest.registered_items[iname].description or "<unknown>").." ("..iname..") out of the machine.]"..
			"label[0,3;There are "..available.." items available.]"..
			"label[0,4;Yo can take out a maximum of "..maxcount.." in one step.]"..
			buyingstr..
					"field[0.5,6.4;1.5,1;icnt;Count;"..(buying or maxcount).."]button[2,6;3,1;buy;Take!]button[2,7;3,1;back;Back]"


		)
		end,
		hdlr=function(player, restformname, fields)
			local posstr, iname=string.match(restformname, "^([^_]+)_(.+)$")
			--print(restformname)
			local pos=posstr and minetest.string_to_pos(posstr)
			if fields.back then
				economy.formspecs.pvendingown.open(player, pos, 1)
			elseif fields.buy then
				local tobuy=tonumber(fields.icnt)
				if not tobuy then
					economy.formspecs.pvendingitemtakeout.open(player, pos, iname)
					return
				end

				local meta=minetest.get_meta(pos)
				if not meta then return end
				if not meta:get_string("owner")==economy.pname(player) then return end
				local available=meta:get_int("ic_"..iname)
				if available<1 then
					economy.formspecs.pvendingown.open(player, pos, 1)
				end

				if not minetest.registered_items[iname] then return end

				local maxcount=math.min(minetest.registered_items[iname].stack_max, available)

				if tobuy>maxcount or tobuy<1 then
					economy.formspecs.pvendingitemtakeout.open(player, pos, iname, tobuy)
					return
				end
				local inv=player:get_inventory()
				local stack=ItemStack(iname.." "..tobuy)
				if inv:room_for_item("main", stack) then
					inv:add_item("main", stack)
					meta:set_int("ic_"..iname, available-tobuy)
					economy.formspecs.pvendingown.open(player, pos, 1)
				else
					economy.formspecs.pvendingitemtakeout.open(player, pos, iname, tobuy, true)
				end

			end

		end
	},
	pvendinginput={
		open=function(player, pos)
			minetest.show_formspec(economy.pname(player), "economy_pvendinginput_"..minetest.pos_to_string(pos), [[
				size[8,8]
				label[0,0;Your balance: ]]..economy.moneyof(player:get_player_name())..[[ ŧ]
				button[1,1;3,1;buy;Back]
				list[nodemeta:]]..pos.x..","..pos.y..","..pos.z..[[;sell;2,2;1,1;]
				]].."label[1,3;Put items here to offer them in the machine.]"..[[
					list[current_player;main;0,4;8,4;]
					]])
		end,
		hdlr=function(player, restformname, fields)
			if fields.buy then
				local pos=minetest.string_to_pos(restformname)
				economy.formspecs.pvendingown.open(player, pos)
			end
		end
	},
	--other players system
	pvending={
		open=function(player, pos, page)
			page=tonumber(page)
			if not page then
				page=1
			end
			local meta=minetest.get_meta(pos)
			if not meta then return end

			local idsp={}
			local inametbl={}
			local metatable=meta:to_table().fields
			for k,v in pairs(metatable) do
				-- c:count, p: price
				-- format: i[c/p]_iname
				local what,iname=string.match(k, "^i([cp])_(.+)$")
				if what and iname then
					if not inametbl[iname] then inametbl[iname]={} end
					inametbl[iname][what]=meta:get_int("i"..what.."_"..iname)

				end
			end
			for k,v in pairs(inametbl) do
				if v.p and v.c and v.c>0 then
					table.insert(idsp,1,{name=k, price=v.p, count=v.c})
				end
			end

			local totalPages=math.ceil(#idsp/10)
			if page<1 then page=1 end
			if page>totalPages then page=totalPages end

			local formspec="size[8,8]label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ. This machine belongs to "..meta:get_string("owner").."]"..
				"label[0,0.5;This machine sells::]"

			if #idsp==0 then
				formspec=formspec.."label[0,2;This machine has nothing to sell at the moment..]"
			end

			if page~=1 then formspec=formspec.."button[5,6.5;1,1;page_"..(page-1)..";<<]" end
			if page~=totalPages then formspec=formspec.."button[6,6.5;1,1;page_"..(page+1)..";>>]" end

			for i=page*10-9,page*10 do
				if idsp[i] then
					if idsp[i].count>0 then
						--formspec=formspec.."item_image_button[1,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"
						--.."label[2,"..(((i-1)%10)*0.5+1)..";Verkauf "..idsp[i].price.." ŧ / Kauf "..economy.buyprice(idsp[i].price).." ŧ ("..idsp[i].count.." verfügbar)]"
						formspec=formspec.."item_image_button[0,"..(((i-1)%10)*0.5+1)..";0.6,0.6;"..idsp[i].name..";buy_"..idsp[i].name..";]"..
						"label[0.5,"..(((i-1)%10)*0.5+1)..";("..idsp[i].count..") "..economy.itemdesc(idsp[i].name).."]"..
						"label[4,"..(((i-1)%10)*0.5+1)..";Price: "..idsp[i].price.." ŧ]"
					end
				end
			end

			minetest.show_formspec(economy.pname(player), "economy_pvending_"..minetest.pos_to_string(pos), formspec)
		end,
		hdlr=function(player, restformname, fields)
			if not fields.quit then
				local pos=minetest.string_to_pos(restformname)
				for k,_ in pairs(fields) do
					local d=string.match(k, "^buy_(.+)$")
					if d then
						economy.formspecs.pvendingbuyitem.open(player, pos, d)
					end
					d=string.match(k, "^page_(%d+)$")
					if d then
						economy.formspecs.pvending.open(player, pos, d)
						return
					end
				end
			end
		end
	},
	pvendingbuyitem={
		open=function(player, pos, iname, buying, cantafford, toomanyitems)

			local meta=minetest.get_meta(pos)
			if not meta then return end
			local available=meta:get_int("ic_"..iname)
			if available<1 then return end

			if not minetest.registered_items[iname] then return end

			local maxcount=math.min(minetest.registered_items[iname].stack_max, available)
			local buyprice=meta:get_int("ip_"..iname)

			local buyingstr=""
			if cantafford then
				buyingstr="label[0,5;Insufficient funds!]"
			elseif toomanyitems then
				buyingstr="label[0,5;Inventory full!]"
			elseif buying then
				if buying>maxcount then
					buyingstr="label[0,5;This amount is greater than the maximum.]"
				elseif buying<1 then
					buyingstr="label[0,5;You can't buy less than 1 item.]"
				else
					buyingstr="label[0,5;"..buying.." items cost "..buying*buyprice.." ŧ]"
				end
			end

			minetest.show_formspec(economy.pname(player), "economy_pvendingbuyitem_"..minetest.pos_to_string(pos).."_"..iname,
			"size[8,8]item_image[5,1;2,2;"..iname.."]"..
			"label[0,0;Your balance: "..economy.moneyof(player:get_player_name()).." ŧ]"..
			"label[0,1;You are buying "..(minetest.registered_items[iname].description or "<unknown>").." ("..iname..")]"..
			"label[0,2;Price per item: "..buyprice.." ŧ]"..
			"label[0,3;There are "..available.." items available.]"..
			"label[0,4;You can buy a maximum of "..maxcount.." items in one step.]"..
			buyingstr..
					"field[0.5,6.4;1.5,1;icnt;Count;"..(buying or maxcount).."]button[2,6;3,1;spr;Show price]button[5,6;3,1;buy;Buy!]button[2,7;3,1;back;Back]"
			)
		end,
		hdlr=function(player, restformname, fields)
			local posstr, iname=string.match(restformname, "^([^_]+)_(.+)$")
			--print(restformname)
			local pos=posstr and minetest.string_to_pos(posstr)
			if fields.spr then
				economy.formspecs.pvendingbuyitem.open(player, pos, iname, tonumber(fields.icnt))
			elseif fields.back then
				economy.formspecs.pvending.open(player, pos, 1)
			elseif fields.buy then
				local tobuy=tonumber(fields.icnt)
				if not tobuy then
					economy.formspecs.pvendingbuyitem.open(player, pos, iname)
					return
				end

				local meta=minetest.get_meta(pos)
				if not meta then return end
				local available=meta:get_int("ic_"..iname)
				if available<1 then
					economy.formspecs.pvending.open(player, pos, 1)
				end

				if not minetest.registered_items[iname] then return end

				local maxcount=math.min(minetest.registered_items[iname].stack_max, available)
				local buyprice=meta:get_int("ip_"..iname)

				if tobuy>maxcount or tobuy<1 then
					economy.formspecs.vendingbuyitem.open(player, pos, iname, tobuy)
					return
				end
				local totalprice=tobuy*buyprice
				if economy.canpay(player, totalprice) then
					local inv=player:get_inventory()
					local stack=ItemStack(iname.." "..tobuy)
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
						meta:set_int("ic_"..iname, available-tobuy)
						economy.withdraw(player, totalprice, "Buying "..tobuy.." "..(minetest.registered_items[iname] and minetest.registered_items[iname].description.." ("..iname..")" or iname).." from "..meta:get_string("owner"))
						economy.deposit(meta:get_string("owner"), totalprice, economy.pname(player).." buys "..tobuy.." "..(minetest.registered_items[iname] and minetest.registered_items[iname].description.." ("..iname..")" or iname).." at "..minetest.pos_to_string(pos))
						economy.formspecs.pvending.open(player, pos, 1)
					else
						economy.formspecs.pvendingbuyitem.open(player, pos, iname, tobuy, false, true)
					end
				else
					economy.formspecs.pvendingbuyitem.open(player, pos, iname, tobuy, true)
					return
				end

			end
		end
	},


	bank={
		open=function(player, trans_sum, trans_player, trans_complete, trans_fail)
		local log_form="label[0.5,5.5;Nothing to show]"
		if economy.accountlog[economy.pname(player)] then
			local acc=economy.accountlog[economy.pname(player)]
			log_form=
			(acc[1] and "label[0.5,5;"..acc[1].action.."]label[6,5;"..acc[1].amount.." ŧ]" or "")..
			(acc[2] and "label[0.5,5.5;"..acc[2].action.."]label[6,5.5;"..acc[2].amount.." ŧ]" or "")..
			(acc[3] and "label[0.5,6;"..acc[3].action.."]label[6,6;"..acc[3].amount.." ŧ]" or "")..
			(acc[4] and "label[0.5,6.5;"..acc[4].action.."]label[6,6.5;"..acc[4].amount.." ŧ]" or "")..
			(acc[5] and "label[0.5,7;"..acc[5].action.."]label[6,7;"..acc[5].amount.." ŧ]" or "")..
			(acc[6] and "label[0.5,7.5;"..acc[6].action.."]label[6,7.5;"..acc[6].amount.." ŧ]" or "")

		end

		minetest.show_formspec(economy.pname(player), "economy_bank_", [[
			size[8,8]
			label[0,0;Your balance: ]]..economy.moneyof(player:get_player_name())..[[ ŧ]
			label[1,0.5;--- Transfer ---]
			field[1,1.5;4,1;sum;Transfer amount;]]..(trans_sum or "100")..[[]field[1,2.5;4,1;plr;Player;]]..(trans_player or "???")..[[]button[1,3.5;2,1;trans;Transfer!]
			]]..(trans_complete and "label[0,3;Transfer successful! "..trans_sum.."ŧ have been transferred to "..trans_player..".]" or "")..(trans_fail and "label[0,3;Failed to transfer (anything misspelled?)]" or "")..
			"label[1,4.5;--- Account history (last event on top) ---]"..
			log_form
	)
		end,
		hdlr=function(player, restformname, fields)
		if fields.trans then
			if fields.sum and tonumber(fields.sum) and tonumber(fields.sum)>0 and economy.canpay(player, tonumber(fields.sum))
			and fields.plr and economy.balance[fields.plr] then

				economy.withdraw(player, tonumber(fields.sum), "Transfer to "..fields.plr)
				economy.deposit(fields.plr, tonumber(fields.sum), "Transfer from "..economy.pname(player))
				if minetest.get_player_by_name(fields.plr) then
					minetest.chat_send_player(fields.plr, ""..fields.sum.."ŧ have been transferred to you by "..economy.pname(player)..". You now have "..economy.moneyof(fields.plr).."ŧ.")
				end
				economy.formspecs.bank.open(player, tonumber(fields.sum), fields.plr, true)
				return
			end

			economy.formspecs.bank.open(player, tonumber(fields.sum), fields.plr, false, true)
		end
		end
	},
}

economy.open_vending=function(pos, player)
	economy.formspecs.vendingsell.open(player, pos)
end
economy.open_bank=function(pos, player)
	economy.formspecs.bank.open(player)
end
economy.open_playervendor=function(pos, player)
	local meta=minetest.get_meta(pos)
	if meta then
		if economy.pname(player)==meta:get_string("owner") then
			economy.formspecs.pvendingown.open(player, pos)
		else
			economy.formspecs.pvending.open(player, pos)
		end
	end
end
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local k,r=string.match(formname, "^economy_([^_]+)_(.*)")
	if k and r then
		if economy.formspecs[k] then
			economy.formspecs[k].hdlr(player, r, fields)
		end
	end
end)
minetest.register_craft({
	output = "economy:playervendor",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"dye:dark_green", "dye:red", "dye:green"},
		{"default:steel_ingot", "default:copperblock", "default:steel_ingot"},
	},
})
	
end --for test disable mod
