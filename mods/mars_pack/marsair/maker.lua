--PIPEWORKS
local overlay = ""
if not marsair.pipeworks then
	marsair.send_items = function(pos, x_velocity, z_velocity, output_name)
		return
	end
else
	overlay = "^pipeworks_tube_connection_metallic.png"
	
	marsair.tube_inject_item = pipeworks.tube_inject_item or function(pos, start_pos, velocity, item)
		local tubed = pipeworks.tube_item(vector.new(pos), item)
		tubed:get_luaentity().start_pos = vector.new(start_pos)
		tubed:setvelocity(velocity)
		tubed:setacceleration(vector.new(0, 0, 0))
	end

	function marsair.send_items(pos, x_velocity, z_velocity)
		-- Send items on their way in the pipe system.
		local meta = minetest.get_meta(pos) 
		local inv = meta:get_inventory()
		local i = 0
		for _, stack in ipairs(inv:get_list("main")) do
			i = i + 1
			if stack then
				local item = stack:to_table()
				if item then 
					marsair.tube_inject_item(pos, pos, vector.new(x_velocity, 0, z_velocity), item)
					stack:clear()
					inv:set_stack("main", i, stack)
					return
				end
			end
		end
	end
end

marsair.needed_air = {name="marssurvive:air", count=marsairconfig.need_air_generation_count, wear=0, metadata=""}

--air generation
function marsair.generate(pos)
	local new_item =  marsair.needed_air
	if not marsair.is_airflower({x=pos.x, y=pos.y+1, z=pos.z}) then return end
	if (minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "marsair:pot_lid") then
		return end
	local meta = minetest.get_meta(pos) 
	local inv = meta:get_inventory()
	inv:add_item("main", new_item)
	
		
	--send with pipeworks
	local node = minetest.get_node(pos)
	local pos1 = vector.new(pos)
	local x_velocity = 0
	local z_velocity = 0
	
	local rules = {
		{x=0, z=-1}, 
		{x=0, z=1}, 
		{x=-1, z=0}, 
		{x=1, z=0}, 
	}
	
	for _, vel in pairs(rules) do
		pos1.x = pos.x+vel.x
		pos1.z = pos.z+vel.z
		local node1 = minetest.get_node(pos1) 
		if minetest.get_item_group(node1.name, "tubedevice") > 0 then
			marsair.send_items(pos, vel.x, vel.z)
		end
	end
end

--tree-air generation
function marsair.clean(pos)
	local new_item = marsair.needed_air
	local status = false
	local positions = minetest.find_nodes_in_area({y=pos.y-2, x=pos.x-2, z=pos.z-2},
									     {y=pos.y+2, x=pos.x+2, z=pos.z+2},
									     "marsair:air_tree")
	for i, v in pairs(positions) do
		local node_between = vector.multiply(vector.subtract(pos, v), 0.5)
		node_between =vector.add(v, node_between)
		node_between = minetest.get_node(node_between).name
		if node_between == "marsair:air_tree" or 
			node_between == "marsair:air" or 
			node_between == "marsair:air_stable" or 
			node_between == "marsair:tree_air_cleaner" or 
			node_between == "air" then
			if status == false then
				status = true
				local meta = minetest.get_meta(pos) 
				local inv = meta:get_inventory()
				inv:add_item("main", new_item)
			end
			marssurvive.replacenode(v)
		end
	end
		
	
		
	--send with pipeworks
	local node = minetest.get_node(pos)
	local pos1 = vector.new(pos)
	local x_velocity = 0
	local z_velocity = 0
	
	local rules = {
		{x=0, z=-1}, 
		{x=0, z=1}, 
		{x=-1, z=0}, 
		{x=1, z=0}, 
	}
	
	for _, vel in pairs(rules) do
		pos1.x = pos.x+vel.x
		pos1.z = pos.z+vel.z
		local node1 = minetest.get_node(pos1) 
		if minetest.get_item_group(node1.name, "tubedevice") > 0 then
			marsair.send_items(pos, vel.x, vel.z)
		end
	end
end





local function round(v)
	return math.floor(v + 0.5)
end

local formspec =
	"invsize[8,9;]"..
	"list[current_name;main;0,1;4,1;]"..
	"list[current_player;main;0,5;8,4;]"..
	"label[0,0;Air Maker]"..
	"listring[current_player;main]"
	
minetest.register_node("marsair:pot_lid", {
	description = "airmaker lid (You Hacker you!)",
	tiles = {
		"airmaker_lid_glass.png",
		"airmaker_lid_glass.png",
		"airmaker_lid_glass.png",
		"airmaker_lid_glass.png",
		"airmaker_lid_glass.png",
		"airmaker_lid_glass.png"
	},
	inventory_image = "armaker_lid_inv.png",
	wield_image = "armaker_lid_inv.png",
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {cracky=50, not_in_creative_inventory=1},
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -1.5, -0.5, 0.5, -0.5, 0.5}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5625, -0.1875, 0.1875, -0.5, 0.1875}, -- NodeBox13
			{-0.25, -0.625, -0.25, 0.25, -0.5625, 0.25}, -- NodeBox14
			{-0.3125, -0.6875, -0.3125, 0.3125, -0.625, 0.3125}, -- NodeBox15
			{-0.375, -0.75, -0.375, 0.375, -0.6875, 0.375}, -- NodeBox16
			{-0.4375, -0.75, 0.375, 0.4375, -1.5, 0.4375}, -- NodeBox17
			{-0.4375, -0.75, -0.4375, 0.4375, -1.5, -0.375}, -- NodeBox18
			{0.375, -0.75, -0.4375, 0.4375, -1.5, 0.4375}, -- NodeBox19
			{-0.4375, -0.75, -0.4375, -0.375, -1.5, 0.4375}, -- NodeBox20
		}
	},
	sounds = default.node_sound_glass_defaults()
})
	
minetest.register_node("marsair:airmaker", {
	description = "Airmaker",
	tiles = {
		{
			image = "airmaker_top.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.2
			}
		},
		"airmaker_bottom.png"..overlay,
		"airmaker_sides.png"..overlay,
		"airmaker_sides.png"..overlay,
		"airmaker_sides.png"..overlay,
		"airmaker_sides.png"..overlay,
	},
	paramtype2 = "facedir",
	groups = {cracky = 2, tubedevice = 0, tubedevice_sender = 1, 
			soil=3, wet = 1, grassland = 1, field = 1},
	soil = {
		base = "marsair:airmaker",
		dry ="marsair:airmaker",
		wet = "marsair:airmaker"
	},
	tube = {
		can_insert = function(pos, node, stack, direction)
			return false
		end,
		connect_sides = {left = 1, right = 1, back = 1, front=1},
	},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 4)
	end,
	on_punch = function(pos, node, clicker, item, _)
		local node = minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z})
		if node.name == "marsair:pot_lid" then
			minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="air", param2=node.param2})
		elseif node.name ~= "scifi_nodes:pot_lid" and node.name == "air" then
			if marsair.is_airflower({x=pos.x, y=pos.y+1, z=pos.z}) then
				minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="marsair:pot_lid", param2=node.param2})
			end
		end
	end,
	after_place_node = marsair.after_place,
	after_dig_node = marsair.after_dig,
	on_destruct = function(pos)
		--need to replace the pot lid
		local replacepos = {x=pos.x, y=pos.y+2, z=pos.z}
		if minetest.get_node(replacepos).name ~= "marsair:pot_lid" then return end
		marssurvive.replacenode(replacepos)
	end
})

minetest.register_node("marsair:tree_air_cleaner", {
	description = "Tree-Air Cleaner",
	tiles = {
		"tree_air_cleaner.png"..overlay,
		"tree_air_cleaner.png"..overlay,
		"tree_air_cleaner.png"..overlay,
		"tree_air_cleaner.png"..overlay,
		"tree_air_cleaner.png"..overlay,
		"tree_air_cleaner.png"..overlay,
	},
	paramtype2 = "facedir",
	groups = {cracky = 2, tubedevice = 0, tubedevice_sender = 1},
	tube = {
		can_insert = function(pos, node, stack, direction)
			return false
		end,
		connect_sides = {left = 1, right = 1, back = 1, front=1, bottom=1, top=1},
	},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 4)
	end,
	after_place_node = marsair.after_place,
	after_dig_node = marsair.after_dig,
})

minetest.register_abm{
        label = "making air",
	nodenames = {"marsair:airmaker"},
	interval = marsairconfig.flower_air_time,
	chance = marsairconfig.flower_air_chance,
	action = function(pos)
		marsair.generate(pos)
	end,
}

minetest.register_abm{
        label = "making tree-air",
	nodenames = {"marsair:tree_air_cleaner"},
	interval = tree_air_maker_time,
	chance = 1,
	action = function(pos)
		marsair.clean(pos)
	end,
}

