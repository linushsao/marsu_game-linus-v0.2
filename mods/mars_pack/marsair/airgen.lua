-- checks if the area is too big or if its outside in 14 directions
marsair.radius = 21

--check if outside or inside
marsair.is_inside = function(pos)
	--TODO: make this better understandable!
	local ch={xp=1,xm=1,yp=1,ym=1,zp=1,zm=1, 
			OOO=1,IOO=1,OIO=1,IIO=1, 
			OOI=1,IOI=1,OII=1,III=1,all=14}
			
	for rad=1,marsair.radius-2,1 do
		--p=plus m=minus
		if ch.xp==1 	and 	minetest.get_node(	{x=pos.x+rad,	y=pos.y,		z=pos.z     }).name~="air" then ch.xp=0 ch.all=ch.all-1 end
		if ch.xm==1 	and 	minetest.get_node(	{x=pos.x-rad,	y=pos.y,		z=pos.z     }).name~="air" then ch.xm=0 ch.all=ch.all-1 end
		if ch.zp==1 	and 	minetest.get_node(	{x=pos.x,		y=pos.y,		z=pos.z+rad }).name~="air" then ch.zp=0 ch.all=ch.all-1 end
		if ch.zm==1 	and 	minetest.get_node(	{x=pos.x,		y=pos.y,		z=pos.z-rad   }).name~="air" then ch.zm=0 ch.all=ch.all-1 end
		if ch.yp==1 	and 	minetest.get_node(	{x=pos.x,		y=pos.y+rad,	z=pos.z     }).name~="air" then ch.yp=0 ch.all=ch.all-1 end
		if ch.ym==1 	and 	minetest.get_node(	{x=pos.x,		y=pos.y-rad,	z=pos.z     }).name~="air" then ch.ym=0 ch.all=ch.all-1 end
		
		--I=plus O=minus
		--for XYZ
		if ch.III==1 	and 	minetest.get_node(	{x=pos.x+rad,	y=pos.y+rad,	z=pos.z+rad }).name~="air" then ch.III=0 ch.all=ch.all-1 end
		if ch.OII ==1 	and 	minetest.get_node(	{x=pos.x-rad,	y=pos.y+rad,	z=pos.z+rad}).name~="air" then ch.OII=0 ch.all=ch.all-1 end
		if ch.IOI ==1 	and 	minetest.get_node(	{x=pos.x+rad,	y=pos.y-rad,	z=pos.z+rad}).name~="air" then ch.IOI=0 ch.all=ch.all-1 end
		if ch.OOI==1 	and 	minetest.get_node(	{x=pos.x-rad,	y=pos.y-rad,	z=pos.z+rad}).name~="air" then ch.OOI=0 ch.all=ch.all-1 end
		
		if ch.IIO==1 	and 	minetest.get_node(	{x=pos.x+rad,	y=pos.y+rad,	z=pos.z-rad}).name~="air" then ch.IIO=0 ch.all=ch.all-1 end
		if ch.OIO==1 	and 	minetest.get_node(	{x=pos.x-rad,	y=pos.y+rad,	z=pos.z-rad}).name~="air" then ch.OIO=0 ch.all=ch.all-1 end
		if ch.IOO==1 	and 	minetest.get_node(	{x=pos.x+rad,	y=pos.y-rad,	z=pos.z-rad}).name~="air" then ch.IOO=0 ch.all=ch.all-1 end
		if ch.OOO==1 	and 	minetest.get_node(	{x=pos.x-rad,	y=pos.y-rad,	z=pos.z-rad}).name~="air" then ch.OOO=0 ch.all=ch.all-1 end
		
		if ch.all<=0 then return true end
	end
	return false
end

-- spread air gass in a level system
--level:
--3
--23
--123
--0123
--123
--23
--3

--[[
minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"marsair:air"},
	interval = 3,
	chance = 1,
	action = function(fill_pos)
		for i=1,17,1 do
			local source_pos=minetest.find_node_near(fill_pos, 1,{"marsair:air"})
			if source_pos==nil then return end
			local source_node=minetest.get_node(source_pos)
			
			if source_node.name=="marsair:air" then
				local level=minetest.get_meta(source_pos):get_int("level")
				if level>0 and level<marsair.radius then
					minetest.set_node(fill_pos, {name = "marsair:air"})
					minetest.get_meta(fill_pos):set_int("level",level+1)
				end
			end
		end
	end,
})]]--

minetest.register_abm({
	nodenames = {"marsair:air"},
	neighbors = {"air"},
	interval = 3,
	chance = 1,
	action = function(pos)
		for _,fill_pos in pairs(minetest.find_nodes_in_area(
		    {x=pos.x-1, y=pos.y-1, z=pos.z-1},
		    {x=pos.x+1, y=pos.y+1, z=pos.z+1}, "air")) do
			local level = minetest.get_meta(pos):get_int("level")
			if level>0 and level<marsair.radius then
			   minetest.set_node(fill_pos, {name = "marsair:air"})
			   minetest.get_meta(fill_pos):set_int("level",level+1)
			end
		end
	end,
})

marsair.spread_air = function(pos)
	local success = 0
	for i=1,17,1 do
		--airgenerator every time 0
		minetest.get_meta(pos):set_int("level",0)
		local fill_pos=minetest.find_node_near(pos,1,{"air"})
		if fill_pos~=nil then
			minetest.set_node(fill_pos, {name = "marsair:air"})
			minetest.get_meta(fill_pos):set_int("level",1)
			local success = 1
		else
			break
		end
	end
	return success
end
--end level system


marsair.use_air_gene = function(pos, player)
	if player and minetest.is_protected(pos,player:get_player_name()) then return end
	
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local needed_air = {name="marsair:air", count=8, wear=0, metadata=""}
	
	--check for inside/outside (try to not generate outside of a house)
	if not marsair.is_inside(pos) then
		minetest.get_meta(pos):set_string("infotext", "Air Generator [This area is too big (max " .. marsair.radius-1 .. "steps) you have to rebuild]")
		return
	end
	
	--check for enougth air in inventory
	if inv:contains_item("main", needed_air) then
		inv:remove_item("main", needed_air)
	else 
		minetest.get_meta(pos):set_string("infotext", "Air Generator [not enought air u need at least 8 inside]")
		return
	end
	
	if marsair.spread_air(pos) then
		--minetest.swap_node(pos, {name = "marsair:airgen" .. (i-1)})
		minetest.get_meta(pos):set_string("infotext", "Air Generator")
		minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,}) 
	end
end


--airgen registration
local airgen_side_texture = "mars_airgen.png"
if marsair.pipeworks then
	airgen_side_texture = "mars_airgen_pipe.png"
end

minetest.register_node("marsair:airgen", {
	description = "Air Generator",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png", 
			{
				image = airgen_side_texture,
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.1
				},
			}
		},
	groups = {crumbly = 2, tubedevice = 1, tubedevice_receiver = 1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Air Generator")
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", 	"invsize[8,9;]"..
								"list[current_name;main;0,1;4,1;]"..
								"list[current_player;main;0,5;8,4;]"..
								"label[0,0;Air Generator]"..
								"button_exit[0,3;3,0.7;generate;generate Air]"..
								"listring[current_player;main]"
		)
		local inv = meta:get_inventory()
		inv:set_size("main", 4)
		
		--for airleak
		meta:set_int("leak", 0)
	end,
	on_receive_fields = function(pos, formname, fields, player)
		if fields.generate then
			marsair.use_air_gene(pos, player)
		end
		--print(pos, dump(player), dump(fields))
	end,
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if not inv:room_for_item("main", stack) then
				marsair.use_air_gene(pos, false)
				inv:remove_item("main", stack)
			end
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			return true
		end,
		connect_sides = {left = 1, right = 1, back = 1, front=1, bottom=1},
	},
	after_place_node = marsair.after_place,
	after_dig_node = marsair.after_dig,
	mesecons = {effector = {
		rules = {
			{x=0,  y=0,  z=-1},
			{x=1,  y=0,  z=0},
			{x=-1, y=0,  z=0},
			{x=0,  y=0,  z=1},
		},
		action_on = function (pos, node)
			marsair.use_air_gene(pos, false)
		end,
	}},
})

minetest.register_node("marsair:airgen_admin", {
	description = "Air Generator (Admin)",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png", 
			{
				image = airgen_side_texture,
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.1
				},
			}
		},
	groups = {crumbly=2,tubedevice = 1, tubedevice_receiver = 1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		marsair.spread_air(pos)
		return itemstack
	end,
	mesecons = {effector = {
		rules = {
			{x=0,  y=0,  z=-1},
			{x=1,  y=0,  z=0},
			{x=-1, y=0,  z=0},
			{x=0,  y=0,  z=1},
		},
		action_on = function (pos, node)
			marsair.spread_air(pos)
			return 
		end,
	}},
})

minetest.register_alias("marssurvive:airgen_unlimited", "marsair:airgen_admin")
minetest.register_alias("marssurvive:airgen_public", "marsair:airgen_admin")
