smartshop={user={},tmp={},dir={{x=0,y=0,z=-1},{x=-1,y=0,z=0},{x=0,y=0,z=1},{x=1,y=0,z=0}},dpos={
{{x=0.2,y=0.2,z=0},{x=-0.2,y=0.2,z=0},{x=0.2,y=-0.2,z=0},{x=-0.2,y=-0.2,z=0}},
{{x=0,y=0.2,z=0.2},{x=0,y=0.2,z=-0.2},{x=0,y=-0.2,z=0.2},{x=0,y=-0.2,z=-0.2}},
{{x=-0.2,y=0.2,z=0},{x=0.2,y=0.2,z=0},{x=-0.2,y=-0.2,z=0},{x=0.2,y=-0.2,z=0}},
{{x=0,y=0.2,z=-0.2},{x=0,y=0.2,z=0.2},{x=0,y=-0.2,z=-0.2},{x=0,y=-0.2,z=0.2}}}
}

minetest.register_craft({
	output = "smartshop:shop",
	recipe = {
		{"default:chest_locked", "default:chest_locked", "default:chest_locked"},
		{"default:sign_wall_wood", "default:chest_locked", "default:sign_wall_wood"},
		{"default:sign_wall_wood", "default:torch", "default:sign_wall_wood"},
	}
})

smartshop.use_offer=function(pos,player,n)
	local pressed={}
	pressed["buy" .. n]=true
	smartshop.user[player:get_player_name()]=pos
	smartshop.receive_fields(player,pressed)
	smartshop.user[player:get_player_name()]=nil
	smartshop.update(pos)


end

smartshop.get_offer=function(pos)
	if not pos or not minetest.get_node(pos) then return end
	if minetest.get_node(pos).name~="smartshop:shop" then return end
	local meta=minetest.get_meta(pos)
	local inv=meta:get_inventory()
	local offer={}
	for i=1,4,1 do
		offer[i]={
		give=inv:get_stack("give" .. i,1):get_name(),
		give_count=inv:get_stack("give" .. i,1):get_count(),
		pay=inv:get_stack("pay" .. i,1):get_name(),
		pay_count=inv:get_stack("pay" .. i,1):get_count(),
		}
	end
	return offer
end


smartshop.receive_fields=function(player,pressed)
		if pressed.customer then
			return smartshop.showform(smartshop.user[player:get_player_name()],player,true)
		elseif pressed.sellall then
			local pos=smartshop.user[player:get_player_name()]
			local meta=minetest.get_meta(pos)
			local pname=player:get_player_name()
			if meta:get_int("sellall")==0 then
				meta:set_int("sellall",1)
				minetest.chat_send_player(pname, "Sell your stock and give line")
			else
				meta:set_int("sellall",0)
				minetest.chat_send_player(pname, "Sell your stock only")
			end
		elseif pressed.tooglelime then
			local pos=smartshop.user[player:get_player_name()]
			local meta=minetest.get_meta(pos)
			local pname=player:get_player_name()
			if meta:get_int("type")==0 then
				meta:set_int("type",1)
				minetest.chat_send_player(pname, "Your stock is limeted")
			else
				meta:set_int("type",0)
				minetest.chat_send_player(pname, "Your stock is unlimeted")
			end
		elseif not pressed.quit then
			local n=1
			for i=1,4,1 do
				n=i
				if pressed["buy" .. i] then break end
			end
			local pos=smartshop.user[player:get_player_name()]
			local meta=minetest.get_meta(pos)
			local type=meta:get_int("type")
			local sellall=meta:get_int("sellall")
			local inv=meta:get_inventory()
			local pinv=player:get_inventory()
			local pname=player:get_player_name()
			if pressed["buy" .. n] then
				local name=inv:get_stack("give" .. n,1):get_name()
				local stack=name .." ".. inv:get_stack("give" .. n,1):get_count()
				local pay=inv:get_stack("pay" .. n,1):get_name() .." ".. inv:get_stack("pay" .. n,1):get_count()
				if name~="" then
					if type==1 and inv:room_for_item("main", pay)==false then minetest.chat_send_player(pname, "Error: The owners stock is full, cant receive, exchange aborted.") return end
					if type==1 and sellall==1 and inv:contains_item("main", stack)==false and inv:contains_item("give" .. n, stack)==true then
						inv:add_item("main", stack)
						inv:remove_item("give" .. n, stack)
					end
					if type==1 and inv:contains_item("main", stack)==false then minetest.chat_send_player(pname, "Error: The owners stock is end.") return end
					if not pinv:contains_item("main", pay) then minetest.chat_send_player(pname, "Error: You dont have enough in your inventory to buy this, exchange aborted.") return end
					if not pinv:room_for_item("main", stack) then minetest.chat_send_player(pname, "Error: Your inventory is full, exchange aborted.") return end
					pinv:remove_item("main", pay)
					pinv:add_item("main", stack)
					if type==1 then 
						inv:remove_item("main", stack)
						inv:add_item("main", pay)
					end
				end
			end
		else
			local pos=smartshop.user[player:get_player_name()]
			smartshop.update_info(pos)
			if smartshop.user[player:get_player_name()] or minetest.check_player_privs(player:get_player_name(), {protection_bypass=true}) then
				local meta=minetest.get_meta(smartshop.user[player:get_player_name()])
				if meta:get_string("owner")==player:get_player_name() then
					smartshop.update(smartshop.user[player:get_player_name()],"update")
				end
			end
			smartshop.user[player:get_player_name()]=nil
		end
end

minetest.register_on_player_receive_fields(function(player, form, pressed)
	if form=="smartshop.showform" then
		smartshop.receive_fields(player,pressed)
	end
end)




smartshop.update_info=function(pos)
	local meta=minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local owner=meta:get_string("owner")
	local gve=0
	if meta:get_int("sellall")==1 then gve=1 end
	if meta:get_int("type")==0 then
		meta:set_string("infotext","(Smartshop by " .. owner ..") Stock is unlimeted")
		return false
	end
	local name=""
	local count=0
	local stuff={}
	for i=1,4,1 do
		stuff["count" ..i]=inv:get_stack("give" .. i,1):get_count()
		stuff["name" ..i]=inv:get_stack("give" .. i,1):get_name()
		stuff["stock" ..i]=gve*stuff["count" ..i]
		stuff["buy" ..i]=0
		for ii=1,32,1 do
			name=inv:get_stack("main",ii):get_name()
			count=inv:get_stack("main",ii):get_count()
			if name==stuff["name" ..i] then
				stuff["stock" ..i]=stuff["stock" ..i]+count
			end
		end
		local nstr=(stuff["stock" ..i]/stuff["count" ..i]) ..""
		nstr=nstr.split(nstr, ".")
		stuff["buy" ..i]=tonumber(nstr[1])

		if stuff["name" ..i]=="" or stuff["buy" ..i]==0 then
			stuff["buy" ..i]=""
			stuff["name" ..i]=""
		else
			if string.find(stuff["name" ..i],":")~=nil then
				stuff["name" ..i]=stuff["name" ..i].split(stuff["name" ..i],":")[2]
			end
			stuff["buy" ..i]="(" ..stuff["buy" ..i] ..") "
			stuff["name" ..i]=stuff["name" ..i] .."\n"
		end
	end
		meta:set_string("infotext",
		"(Smartshop by " .. owner ..") Purchases left:\n"
		.. stuff.buy1 ..  stuff.name1
		.. stuff.buy2 ..  stuff.name2
		.. stuff.buy3 ..  stuff.name3
		.. stuff.buy4 ..  stuff.name4
		)
end




smartshop.update=function(pos,stat)
--clear
	local spos=minetest.pos_to_string(pos)
	for _, ob in ipairs(minetest.env:get_objects_inside_radius(pos, 2)) do
		if ob and ob:get_luaentity() and ob:get_luaentity().smartshop and ob:get_luaentity().pos==spos then
			ob:remove()	
		end
	end
	if stat=="clear" then return end
--update
	local meta=minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local node=minetest.get_node(pos)
	local dp = smartshop.dir[node.param2+1]
	if not dp then return end
	pos.x = pos.x + dp.x*0.01
	pos.y = pos.y + dp.y*6.5/16
	pos.z = pos.z + dp.z*0.01
	for i=1,4,1 do
		local item=inv:get_stack("give" .. i,1):get_name()
		local pos2=smartshop.dpos[node.param2+1][i]
		if item~="" then
			smartshop.tmp.item=item
			smartshop.tmp.pos=spos
			local e = minetest.env:add_entity({x=pos.x+pos2.x,y=pos.y+pos2.y,z=pos.z+pos2.z},"smartshop:item")
			e:setyaw(math.pi*2 - node.param2 * math.pi/2)
		end
	end
end


minetest.register_entity("smartshop:item",{
	hp_max = 1,
	visual="wielditem",
	visual_size={x=.20,y=.20},
	collisionbox = {0,0,0,0,0,0},
	physical=false,
	textures={"air"},
	smartshop=true,
	type="",
	on_activate = function(self, staticdata)
		if smartshop.tmp.item ~= nil then
			self.item=smartshop.tmp.item
			self.pos=smartshop.tmp.pos
			smartshop.tmp={}
		else
			if staticdata ~= nil and staticdata ~= "" then
				local data = staticdata:split(';')
				if data and data[1] and data[2] then
					self.item = data[1]
					self.pos = data[2]
				end
			end
		end
		if self.item ~= nil then
			self.object:set_properties({textures={self.item}})
		else
			self.object:remove()
		end
	end,
	get_staticdata = function(self)
		if self.item ~= nil and self.pos ~= nil then
			return self.item .. ';' ..  self.pos
		end
		return ""
	end,
})


smartshop.showform=function(pos,player,re)
	local meta=minetest.get_meta(pos)
	local creative=meta:get_int("creative")
	local inv = meta:get_inventory()
	local gui=""
	local spos=pos.x .. "," .. pos.y .. "," .. pos.z
	local owner=meta:get_string("owner")==player:get_player_name()
	if minetest.check_player_privs(player:get_player_name(), {protection_bypass=true}) then owner=true end
	if re then owner=false end
	smartshop.user[player:get_player_name()]=pos
	if owner then
		gui=""
		.."size[8,10]"
		.."button_exit[6,0;1.5,1;customer;Customer]"
		.."button[7.2,0;1,1;sellall;All]"
		.."label[0,0.2;Item:]"
		.."label[0,1.2;Price:]"
		.."list[nodemeta:" .. spos .. ";give1;2,0;1,1;]"
		.."list[nodemeta:" .. spos .. ";pay1;2,1;1,1;]"
		.."list[nodemeta:" .. spos .. ";give2;3,0;1,1;]"
		.."list[nodemeta:" .. spos .. ";pay2;3,1;1,1;]"
		.."list[nodemeta:" .. spos .. ";give3;4,0;1,1;]"
		.."list[nodemeta:" .. spos .. ";pay3;4,1;1,1;]"
		.."list[nodemeta:" .. spos .. ";give4;5,0;1,1;]"
		.."list[nodemeta:" .. spos .. ";pay4;5,1;1,1;]"
		if creative==1 then
			gui=gui .."label[0.5,-0.4;Your stock is unlimeted becaouse you have creative or give]"
			.."button[6,1;2.2,1;tooglelime;Toogle lime]"
		end
		gui=gui
		.."list[nodemeta:" .. spos .. ";main;0,2;8,4;]"
		.."list[current_player;main;0,6.2;8,4;]"
		.."listring[nodemeta:" .. spos .. ";main]"
		.."listring[current_player;main]"
	else
		gui=""
		.."size[8,6]"
		.."list[current_player;main;0,2.2;8,4;]"
		.."label[0,0.2;Item:]"
		.."label[0,1.2;Price:]"
		.."list[nodemeta:" .. spos .. ";give1;2,0;1,1;]"
		.."item_image_button[2,1;1,1;".. inv:get_stack("pay1",1):get_name() ..";buy1;\n\n\b\b\b\b\b" .. inv:get_stack("pay1",1):get_count() .."]"
		.."list[nodemeta:" .. spos .. ";give2;3,0;1,1;]"
		.."item_image_button[3,1;1,1;".. inv:get_stack("pay2",1):get_name() ..";buy2;\n\n\b\b\b\b\b" .. inv:get_stack("pay2",1):get_count() .."]"
		.."list[nodemeta:" .. spos .. ";give3;4,0;1,1;]"
		.."item_image_button[4,1;1,1;".. inv:get_stack("pay3",1):get_name() ..";buy3;\n\n\b\b\b\b\b" .. inv:get_stack("pay3",1):get_count() .."]"
		.."list[nodemeta:" .. spos .. ";give4;5,0;1,1;]"
		.."item_image_button[5,1;1,1;".. inv:get_stack("pay4",1):get_name() ..";buy4;\n\n\b\b\b\b\b" .. inv:get_stack("pay4",1):get_count() .."]"
	end
	minetest.after((0.1), function(gui)
		return minetest.show_formspec(player:get_player_name(), "smartshop.showform",gui)
	end, gui)
end

minetest.register_node("smartshop:shop", {
	description = "Smartshop",
	tiles = {"default_chest_top.png^[colorize:#ffffff77^default_obsidian_glass.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1,tubedevice = 1, tubedevice_receiver = 1},
	drawtype="nodebox",
	node_box = {type="fixed",fixed={-0.5,-0.5,-0.0,0.5,0.5,0.5}},
	paramtype2="facedir",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 10,
	tube = {insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local added = inv:add_item("main", stack)
			return added
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left = 1, right = 1, front = 1, back = 1, top = 1, bottom = 1}},
after_place_node = function(pos, placer)
		local meta=minetest.get_meta(pos)
		meta:set_string("owner",placer:get_player_name())
		meta:set_string("infotext", "Shop by: " .. placer:get_player_name())
		meta:set_int("type",1)
		meta:set_int("sellall",1)
		if minetest.check_player_privs(placer:get_player_name(), {creative=true}) or minetest.check_player_privs(placer:get_player_name(), {give=true}) then
			meta:set_int("creative",1)
			meta:set_int("type",0)
			meta:set_int("sellall",0)
		end
	end,
on_construct = function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("state", 0)
		meta:get_inventory():set_size("main", 32)
		meta:get_inventory():set_size("give1", 1)
		meta:get_inventory():set_size("pay1", 1)
		meta:get_inventory():set_size("give2", 1)
		meta:get_inventory():set_size("pay2", 1)
		meta:get_inventory():set_size("give3", 1)
		meta:get_inventory():set_size("pay3", 1)
		meta:get_inventory():set_size("give4", 1)
		meta:get_inventory():set_size("pay4", 1)
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		smartshop.showform(pos,player)
	end,
allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_meta(pos):get_string("owner")==player:get_player_name() or minetest.check_player_privs(player:get_player_name(), {protection_bypass=true}) then
		return stack:get_count()
		end
		return 0
	end,
allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.get_meta(pos):get_string("owner")==player:get_player_name() or minetest.check_player_privs(player:get_player_name(), {protection_bypass=true}) then
		return stack:get_count()
		end
		return 0
	end,
allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.get_meta(pos):get_string("owner")==player:get_player_name() or minetest.check_player_privs(player:get_player_name(), {protection_bypass=true}) then
		return count
		end
		return 0
	end,
can_dig = function(pos, player)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		if ((meta:get_string("owner")==player:get_player_name() or minetest.check_player_privs(player:get_player_name(), {protection_bypass=true})) and inv:is_empty("main") and inv:is_empty("pay1") and inv:is_empty("pay2") and inv:is_empty("pay3") and inv:is_empty("pay4") and inv:is_empty("give1") and inv:is_empty("give2") and inv:is_empty("give3") and inv:is_empty("give4")) or meta:get_string("owner")=="" then
			smartshop.update(pos,"clear")
			return true
		end
	end,
})