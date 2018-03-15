compost = {}
compost.items = {}

function compost.register_item(name)
	compost.items[name] = true
end


--compost.register_item("default:dirt_with_grass")
compost.register_item("compost:base_material")

minetest.register_node("compost:wood_barrel", {
	description = "Wood Barrel",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, 1/2, -3/8, 1/2},
			{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2}},
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {cracky = 3},
	sounds =  default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		local wielded_item = puncher:get_wielded_item():get_name()
		if compost.items[wielded_item] then
			minetest.set_node(pos, {name = "compost:wood_barrel_1"})
			local w = puncher:get_wielded_item()
			w:take_item(1)
			puncher:set_wielded_item(w)
		end
	end
})

minetest.register_node("compost:wood_barrel_1", {
	description = "Wood Barrel with compost",
	tiles = {"default_wood.png^compost_compost_1.png", "default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, 1/2, -3/8, 1/2},
			{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2},
			{-3/8, -1/2, -3/8, 3/8, 3/8, 3/8}},
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 3},
	sounds =  default.node_sound_wood_defaults(),
})

minetest.register_node("compost:wood_barrel_2", {
	description = "Wood Barrel with compost",
	tiles = {"default_wood.png^compost_compost_2.png", "default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, 1/2, -3/8, 1/2},
			{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2},
			{-3/8, -1/2, -3/8, 3/8, 3/8, 3/8}},
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 3},
	sounds =  default.node_sound_wood_defaults(),
})

minetest.register_node("compost:wood_barrel_3", {
	description = "Wood Barrel",
	tiles = {"default_wood.png^compost_compost_3.png", "default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, 1/2, -3/8, 1/2},
			{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2},
			{-3/8, -1/2, -3/8, 3/8, 3/8, 3/8}},
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 3},
	sounds =  default.node_sound_wood_defaults(),
	on_punch = function(pos, node, player, pointed_thing)
		local p = {x = pos.x + math.random(0, 5)/5 - 0.5, y = pos.y+1, z = pos.z + math.random(0, 5)/5 - 0.5}
		minetest.add_item(p, {name = "default:dirt"})
		minetest.set_node(pos, {name = "compost:wood_barrel"})
	end
})

minetest.register_abm({
	nodenames = {"compost:wood_barrel_1"},
	interval = 5.0,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "compost:wood_barrel_2"})
	end,
})

minetest.register_abm({
	nodenames = {"compost:wood_barrel_2"},
	interval = 5.0,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "compost:wood_barrel_3"})
	end,
})

minetest.register_craft({
	output = "compost:wood_barrel",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "compost:wood_barrel",
	recipe = {
		{"default:wood", "", "default:wood"},
		{"default:wood", "", "default:wood"},
		{"default:wood", "default:wood", "default:wood"}
	}
})


minetest.register_craftitem("compost:base_material", {
    description = "Unfermented compost",
    inventory_image = "base.png",

})

local plant_table = {
	'flowers:rose', 'flowers:tulip','flowers:geranium','flowers:dandelion_yellow',
	'flowers:viola','flowers:dandelion_white',
	'default:grass_1','default:junglegrass','group:leaves','default:jungleleaves',
	'default:pine_needles','moretrees:apple_tree_leaves','glowtest:blueleaf',
	'glowtest:redleaf','glowtest:blackleaf','glowtest:pinkleaf','glowtest:yellowleaf',
	'glowtest:greenleaf','glowtest:whiteleaf','farming_plus:banana_leaves',
	'farming_plus:cocoa_leaves','group:rubber_leaves','mg:pineleaves',
	'mg:savannaleaves','moretrees:beech_leaves','moretrees:birch_leaves',
	'moretrees:fir_leaves','moretrees:jungletree_leaves_green','moretrees:jungletree_leaves_red',
	'moretrees:jungletree_leaves_yellow','moretrees:oak_leaves','moretrees:palm_leaves',
	'moretrees:rubber_tree_leaves','moretrees:sequoia_leaves','moretrees:spruce_leaves',
	'moretrees:willow_leaves'
	}

for i, name in pairs(plant_table) do

	minetest.register_craft({
		output = "compost:base_material 2",
		recipe = {
			{name, name,name },
			{name, name,name },
			{name, name,name }
		}
	})

	minetest.register_craft({
		output = "compost:base_material 1",
		recipe = {
			{'default:mossycobble'}
		}
	})



end
