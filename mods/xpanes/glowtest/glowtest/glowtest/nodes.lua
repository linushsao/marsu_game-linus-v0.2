minetest.register_node("glowtest:tree", {
	description = "Glowing Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	light_source = 8,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
     drop = "default:tree",
	on_place = minetest.rotate_node
})

minetest.register_node("glowtest:stonetree", {
	description = "Glowing Stone Tree",
	tiles = {"glowtest_cursed_tree.png", "glowtest_cursed_tree.png", "glowtest_cursed_tree_top.png"},
	paramtype2 = "facedir",
	light_source = 8,
	groups = {tree=1,cracky=3},
	sounds = default.node_sound_wood_defaults(),
	drop = {
		max_items = 1,
		items = {
			{ items = {'default:lava_source'}, rarity = 100},
			{ items = {'default:tree'} }
		}
	},
	on_place = minetest.rotate_node
})

minetest.register_node("glowtest:blueleaf", {
	description = "Glowing Blue Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_blueleaf.png"},
	paramtype = "light",
	light_source = 8,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
     alpha = 200,
     sunlight_propagates = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:sbluesapling'}, rarity = 20},
			{ items = {'glowtest:mbluesapling'}, rarity = 40},
			{ items = {'glowtest:lbluesapling'}, rarity = 60},
			{ items = {'glowtest:blueleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:redleaf", {
	description = "Glowing Blood Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_redleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:sredsapling'}, rarity = 20},
			{ items = {'glowtest:mredsapling'}, rarity = 40},
			{ items = {'glowtest:lredsapling'}, rarity = 60},
			{ items = {'glowtest:redleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:blackleaf", {
	description = "Glowing Cursed Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_blackleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:sblacksapling'}, rarity = 20},
			{ items = {'glowtest:mblacksapling'}, rarity = 40},
			{ items = {'glowtest:lblacksapling'}, rarity = 60},
			{ items = {'glowtest:blackleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:pinkleaf", {
	description = "Glowing Pink Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_pinkleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:spinksapling'}, rarity = 20},
			{ items = {'glowtest:mpinksapling'}, rarity = 40},
			{ items = {'glowtest:lpinksapling'}, rarity = 60},
			{ items = {'glowtest:pinkleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:yellowleaf", {
	description = "Glowing Yellow Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_yellowleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:syellowsapling'}, rarity = 20},
			{ items = {'glowtest:myellowsapling'}, rarity = 40},
			{ items = {'glowtest:lyellowsapling'}, rarity = 60},
			{ items = {'glowtest:yellowleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:greenleaf", {
	description = "Glowing Green Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_greenleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:sgreensapling'}, rarity = 20},
			{ items = {'glowtest:mgreensapling'}, rarity = 40},
			{ items = {'glowtest:lgreensapling'}, rarity = 60},
			{ items = {'glowtest:greenleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:whiteleaf", {
	description = "Glowing White Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"glowtest_whiteleaf.png"},
	paramtype = "light",
	light_source = 8,
     alpha = 200,
     sunlight_propagates = true,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{ items = {'glowtest:swhitesapling'}, rarity = 20},
			{ items = {'glowtest:mwhitesapling'}, rarity = 40},
			{ items = {'glowtest:lwhitesapling'}, rarity = 60},
			{ items = {'glowtest:whiteleaf'} }
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("glowtest:sgreensapling", {
	description = "Small Green Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_greensapling.png"},
	inventory_image = "glowtest_greensapling.png",
	wield_image = "glowtest_greensapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:mgreensapling", {
	description = "Medium Green Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_greensapling.png"},
	inventory_image = "glowtest_greensapling.png",
	wield_image = "glowtest_greensapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lgreensapling", {
	description = "Large Green Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_greensapling.png"},
	inventory_image = "glowtest_greensapling.png",
	wield_image = "glowtest_greensapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:sbluesapling", {
	description = "Small Blue Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_bluesapling.png"},
	inventory_image = "glowtest_bluesapling.png",
	wield_image = "glowtest_bluesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:mbluesapling", {
	description = "Medium Blue Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_bluesapling.png"},
	inventory_image = "glowtest_bluesapling.png",
	wield_image = "glowtest_bluesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lbluesapling", {
	description = "Large Blue Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_bluesapling.png"},
	inventory_image = "glowtest_bluesapling.png",
	wield_image = "glowtest_bluesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:spinksapling", {
	description = "Small Pink Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_pinksapling.png"},
	inventory_image = "glowtest_pinksapling.png",
	wield_image = "glowtest_pinksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:mpinksapling", {
	description = "Medium Pink Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_pinksapling.png"},
	inventory_image = "glowtest_pinksapling.png",
	wield_image = "glowtest_pinksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lpinksapling", {
	description = "Large Pink Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_pinksapling.png"},
	inventory_image = "glowtest_pinksapling.png",
	wield_image = "glowtest_pinksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:syellowsapling", {
	description = "Small Yellow Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_yellowsapling.png"},
	inventory_image = "glowtest_yellowsapling.png",
	wield_image = "glowtest_yellowsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:myellowsapling", {
	description = "Medium Yellow Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_yellowsapling.png"},
	inventory_image = "glowtest_yellowsapling.png",
	wield_image = "glowtest_yellowsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lyellowsapling", {
	description = "Large Yellow Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_yellowsapling.png"},
	inventory_image = "glowtest_yellowsapling.png",
	wield_image = "glowtest_yellowsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:sredsapling", {
	description = "Small Blood Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_redsapling.png"},
	inventory_image = "glowtest_redsapling.png",
	wield_image = "glowtest_redsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:mredsapling", {
	description = "Medium Blood Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_redsapling.png"},
	inventory_image = "glowtest_redsapling.png",
	wield_image = "glowtest_redsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lredsapling", {
	description = "Large Blood Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_redsapling.png"},
	inventory_image = "glowtest_redsapling.png",
	wield_image = "glowtest_redsapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:swhitesapling", {
	description = "Small White Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_whitesapling.png"},
	inventory_image = "glowtest_whitesapling.png",
	wield_image = "glowtest_whitesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
     selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("glowtest:mwhitesapling", {
	description = "Medium White Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_whitesapling.png"},
	inventory_image = "glowtest_whitesapling.png",
	wield_image = "glowtest_whitesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lwhitesapling", {
	description = "Large White Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_whitesapling.png"},
	inventory_image = "glowtest_whitesapling.png",
	wield_image = "glowtest_whitesapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:sblacksapling", {
	description = "Small Cursed Sapling",
	drawtype = "plantlike",
	visual_scale = 0.7,
	tiles = {"glowtest_blacksapling.png"},
	inventory_image = "glowtest_blacksapling.png",
	wield_image = "glowtest_blacksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:mblacksapling", {
	description = "Medium Cursed Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"glowtest_blacksapling.png"},
	inventory_image = "glowtest_blacksapling.png",
	wield_image = "glowtest_blacksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("glowtest:lblacksapling", {
	description = "Large Cursed Sapling",
	drawtype = "plantlike",
	visual_scale = 2.0,
	tiles = {"glowtest_blacksapling.png"},
	inventory_image = "glowtest_blacksapling.png",
	wield_image = "glowtest_blacksapling.png",
	paramtype = "light",
	walkable = false,
    light_source = 8,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})
