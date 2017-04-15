local pollution_cn={
{"grass","default_grass.png","default:dirt",default.node_sound_dirt_defaults()},
{"dirt","default_dirt.png","default:dirt",default.node_sound_dirt_defaults()},
{"stone","default_stone.png","default:stone",default.node_sound_stone_defaults()},
{"cobble","default_cobble.png","default:cobble",default.node_sound_stone_defaults()},
{"wood","default_wood.png","default:wood",default.node_sound_wood_defaults()},
{"desert_stone","default_desert_stone.png","default:desert_stone",default.node_sound_stone_defaults()},
{"desert_cobble","default_desert_cobble.png","default:desert_cobble",default.node_sound_stone_defaults()},
{"snow","default_snow.png","default:snowblock",default.node_sound_dirt_defaults({footstep = {name = "default_snow_footstep", gain = 0.25},})},
}

cracking_timer = function (pos, elapsed)

	local np=minetest.find_node_near(pos, 8,{
		"default:stone","default:desert_stone",})
	if np==nil then
	np=minetest.find_node_near(pos, 8,{
		"default:dirt",})
	end
	if np==nil then
	np=minetest.find_node_near(pos, 4,{
		"default:snowblock",
		"default:dirt_with_snow",
		"group:wood",
		"default:dirt_with_grass",
		"default:cobble",
		"default:desert_cobble"
	})
	end


	if minetest.is_protected(pos,"") then np=nil end

	if np==nil then
		minetest.set_node(pos, {name="pollution:sbarrel"})
		return false
	end

	local node=minetest.get_node(np)
		if node and node.name then
			local name = node.name
			local npos=minetest.get_node({x=np.x,y=np.y+1,z=np.z}).name
				if name=="default:desert_stone" then		if npos~="air" and npos~="pollution:sbarrel_cracked" then minetest.set_node(np, {name="air"}) else minetest.set_node(np, {name="pollution:cracky_desert_stone"}) end end
				if name=="default:stone" then		if npos~="air" and npos~="pollution:sbarrel_cracked" then minetest.set_node(np, {name="air"}) else minetest.set_node(np, {name="pollution:cracky_stone"}) end end
				if name=="default:dirt" then			if npos~="air" and npos~="pollution:sbarrel_cracked" then minetest.set_node(np, {name="air"}) else minetest.set_node(np, {name="pollution:cracky_dirt"}) end end
				if name=="default:dirt_with_grass" then	minetest.set_node(np, {name="pollution:cracky_grass"}) end
				if name=="default:desert_cobble" then		minetest.set_node(np, {name="pollution:cracky_desert_cobble"}) end
				if name=="default:cobble" then		minetest.set_node(np, {name="pollution:cracky_cobble"}) end
				if name=="default:snowblock"		or  name=="default:dirt_with_snow" then minetest.set_node(np, {name="pollution:cracky_snow"}) end
				if minetest.get_node_group(name, "wood")==1 then	minetest.set_node(np, {name="pollution:cracky_wood"}) end
		end
	return true
end


cracky_timer = function (pos, elapsed)
	local nds = minetest.env:get_objects_inside_radius(pos,1.5)
	for i, ob in pairs(nds) do
		if ob:is_player() then
			local name = minetest.get_node(pos).name
			if name~=nil then
				if minetest.registered_nodes[name].cracky and minetest.registered_nodes[name].cracky < 2 then
					for i = 1, #pollution_cn, 1 do
					if name=="pollution:cracky_" .. pollution_cn[i][1] then minetest.set_node(pos, {name="pollution:cracky_" .. pollution_cn[i][1] .."_2"}) end
					nodeupdate(pos)
					end
				end
			end
		end
	end
	return true
end

minetest.register_node("pollution:sbarrel", {
	description = "Sinkhole barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel4.png"},
	groups = {barrel=3,cracky = 1, level = 2, falling_node=1,not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
	pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_sound_pff(pos)
			minetest.set_node(pos, {name = "pollution:sbarrel_cracked"})
		end
		return true
	end,
})

minetest.register_node("pollution:sbarrel_cracked", {
	description = "Cracked sinkhole barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	drop = 'pollution:sbarrel',
	wield_scale = {x=0.5, y=0.5, z=0.5},
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
	collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel4.png"},
	groups = {barrel=3,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(2)
	end,
	on_timer = cracking_timer,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then pollution_spawn_kmob(pos) end
		return true
	end,
})


for i = 1, #pollution_cn, 1 do
minetest.register_node("pollution:cracky_" .. pollution_cn[i][1], {
	description = "Cracky " .. pollution_cn[i][1],
	tiles = {pollution_cn[i][2]},
	groups = {crumbly = 3, soil = 1,not_in_creative_inventory=1},
	drop = pollution_cn[i][3],
	sounds = pollution_cn[i][4],
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(2)
	end,
	cracky = 1,
	on_timer = cracky_timer,
})

minetest.register_node("pollution:cracky_" .. pollution_cn[i][1] .."_2", {
	description = "Cracky fallen " .. pollution_cn[i][1],
	tiles = {pollution_cn[i][2]},
	groups = {crumbly = 3, soil = 1,falling_node=1,not_in_creative_inventory=1},
	drop = pollution_cn[i][3],
	sounds = pollution_cn[i][4],
})
end