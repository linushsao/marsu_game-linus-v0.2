--Created by Krock
--License: WTFPL

if (bitchange_use_moreores_tin) then
	if(bitchange_need_generate_tin) then
		minetest.register_node(":moreores:mineral_tin", {
				description = "Tin Ore",
				tiles = {"default_stone.png^moreores_mineral_tin.png"},
				groups = {cracky=3},
				sounds = default.node_sound_stone_defaults(),
				drop = 'craft "moreores:tin_lump" 1'
		})
		minetest.register_node(":moreores:tin_block", {
					description = "Tin Block",
					tiles = { "moreores_tin_block.png" },
					groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
					sounds = default.node_sound_stone_defaults()
		})
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = "moreores:mineral_tin",
			wherein        = "default:stone",
			clust_scarcity = 7*7*7,
			clust_num_ores = 3,
			clust_size     = 7,
			height_min     = -31000,
			height_max     = 8,
		})
		minetest.register_craftitem(":moreores:tin_lump", {
			description = "Tin Lump",
			inventory_image = "moreores_tin_lump.png",
		})
		minetest.register_craftitem(":moreores:tin_ingot", {
			description = "Tin Ingot",
			inventory_image = "moreores_tin_ingot.png",
		})
		minetest.register_craft({
			output = "moreores:tin_block",
			recipe = {
				{"moreores:tin_ingot", "moreores:tin_ingot", "moreores:tin_ingot"},
				{"moreores:tin_ingot", "moreores:tin_ingot", "moreores:tin_ingot"},
				{"moreores:tin_ingot", "moreores:tin_ingot", "moreores:tin_ingot"},
			}
		})
		minetest.register_craft({
			output = "moreores:tin_ingot 9",
			recipe = { { "moreores:tin_block" } }
		})
		minetest.register_craft({
			type = 'cooking',
			recipe = "moreores:tin_lump",
			output = "moreores:tin_ingot",
		})
	end
	minetest.register_craft({
		output = "bitchange:coinbase 20",
		recipe = {
			{"moreores:tin_block", "default:pick_diamond"},
			{"moreores:tin_block", ""}
		},
		replacements = { {"default:pick_diamond", "default:pick_diamond"} },
	})
end

if (bitchange_use_technic_zinc) then
	if (bitchange_need_generate_zinc) then
		minetest.register_node(":technic:mineral_zinc", {
			description = "Zinc Ore",
			tile_images = { "default_stone.png^technic_mineral_zinc.png" },
			is_ground_content = true,
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
			drop = 'craft "technic:zinc_lump" 1',
		})
		minetest.register_node(":technic:zinc_block", {
			description = "Zinc Block",
			tiles = { "technic_zinc_block.png" },
			is_ground_content = true,
			groups = {cracky=1, level=2},
			sounds = default.node_sound_stone_defaults()
		})
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = "technic:mineral_zinc",
			wherein        = "default:stone",
			clust_scarcity = 9*9*9,
			clust_num_ores = 4,
			clust_size     = 3,
			height_min     = -31000,
			height_max     = 2,
		})
		minetest.register_craftitem(":technic:zinc_lump", {
			description = "Zinc Lump",
			inventory_image = "technic_zinc_lump.png",
		})
		minetest.register_craftitem(":technic:zinc_ingot", {
			description = "Zinc Ingot",
			inventory_image = "technic_zinc_ingot.png",
		})
		minetest.register_craft({
			output = "technic:zinc_block",
			recipe = {
				{"technic:zinc_ingot", "technic:zinc_ingot", "technic:zinc_ingot"},
				{"technic:zinc_ingot", "technic:zinc_ingot", "technic:zinc_ingot"},
				{"technic:zinc_ingot", "technic:zinc_ingot", "technic:zinc_ingot"},
			}
		})
		minetest.register_craft({
			output = "technic:zinc_block 9",
			recipe = { { "technic:zinc_block" } }
		})
		minetest.register_craft({
			type = 'cooking',
			recipe = "technic:zinc_lump",
			output = "technic:zinc_ingot",
		})
	end
	minetest.register_craft({
		output = "bitchange:coinbase 8",
		recipe = {
			{"technic:zinc_block", "default:pick_diamond"},
			{"technic:zinc_block", ""}
		},
		replacements = { {"default:pick_diamond", "default:pick_diamond"} },
	})
end