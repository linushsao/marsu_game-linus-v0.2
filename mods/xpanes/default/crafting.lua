-- mods/default/crafting.lua

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'default:tree'},
	}
})

minetest.register_craft({
	output = 'default:wood',
	recipe = {
		{'marssurvive:wood'},
	}
})

minetest.register_craft({
	output = 'default:junglewood 4',
	recipe = {
		{'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'default:pine_wood 4',
	recipe = {
		{'default:pine_tree'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood 4',
	recipe = {
		{'default:acacia_tree'},
	}
})

minetest.register_craft({
	output = 'default:aspen_wood 4',
	recipe = {
		{'default:aspen_tree'},
	}
})

minetest.register_craft({
	output = 'default:stick 4',
	recipe = {
		{'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:stick 4',
	recipe = {
		{'default:wood'},
	}
})


minetest.register_craft({
	output = 'default:sign_wall_steel 3',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_wood 3',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_wood 3',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
		{'', 'group:stick', ''},
	}
})


minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'group:stick'},
	}
})


minetest.register_craft({
	output = 'default:pick_wood',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_wood',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})


minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'group:cobble', 'group:cobble', 'group:cobble'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_diamond',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_wood',
	recipe = {
		{'group:wood'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_wood',
	recipe = {
		{'default:wood'},
		{'group:stick'},
		{'group:stick'},
	}
})


minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'group:stone'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel',
	recipe = {
		{'default:steel_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_mese',
	recipe = {
		{'default:mese_crystal'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_diamond',
	recipe = {
		{'default:diamond'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:wood', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'default:wood', 'default:wood'},
		{'default:wood', 'group:stick'},
		{'', 'group:stick'},
	}
})


minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone'},
		{'group:stone', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'default:diamond', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:stick', 'group:wood'},
		{'group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'default:wood', 'default:wood'},
		{'group:stick', 'default:wood'},
		{'group:stick',''},
	}
})


minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone'},
		{'group:stick', 'group:stone'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'group:stick', 'default:steel_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot'},
		{'group:stick', 'default:bronze_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'group:stick', 'default:mese_crystal'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'group:stick', 'default:diamond'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sword_wood',
	recipe = {
		{'group:wood'},
		{'group:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_wood',
	recipe = {
		{'default:wood'},
		{'default:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_stone',
	recipe = {
		{'group:stone'},
		{'group:stone'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel',
	recipe = {
		{'default:steel_ingot'},
		{'default:steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'default:bronze_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_mese',
	recipe = {
		{'default:mese_crystal'},
		{'default:mese_crystal'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_diamond',
	recipe = {
		{'default:diamond'},
		{'default:diamond'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:rail 24',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:chest',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:chest',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', '', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})


minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'default:steel_ingot', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:steel_ingot', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})


minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'group:stone', '', 'group:stone'},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:cobble', 'group:cobble', 'group:cobble'},
		{'group:cobble', '', 'group:cobble'},
		{'group:cobble', 'group:cobble', 'group:cobble'},
	}
})


minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot",
	recipe = {"default:steel_ingot", "default:copper_ingot"},
})

minetest.register_craft({
	output = 'default:coalblock',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'default:coal_lump 9',
	recipe = {
		{'default:coalblock'},
	}
})

minetest.register_craft({
	output = 'default:steelblock',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:steel_ingot 9',
	recipe = {
		{'default:steelblock'},
	}
})

minetest.register_craft({
	output = 'default:copperblock',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'default:copper_ingot 9',
	recipe = {
		{'default:copperblock'},
	}
})

minetest.register_craft({
	output = 'default:bronzeblock',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
	}
})

minetest.register_craft({
	output = 'default:bronze_ingot 9',
	recipe = {
		{'default:bronzeblock'},
	}
})

minetest.register_craft({
	output = 'default:goldblock',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:gold_ingot 9',
	recipe = {
		{'default:goldblock'},
	}
})

minetest.register_craft({
	output = 'default:diamondblock',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'default:diamond 9',
	recipe = {
		{'default:diamondblock'},
	}
})

--[[
minetest.register_craft({
	output = 'default:sandstone',
	recipe = {
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
	}
})
--]]

minetest.register_craft({
	output = 'default:sand 4',
	recipe = {
		{'','default:sandstone',''},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'default:sandstonebrick 4',
	recipe = {
		{'','default:sandstone', 'default:sandstone'},
		{'','default:sandstone', 'default:sandstone'},
		{'','', ''},

	}
})

minetest.register_craft({
	output = 'default:clay',
	recipe = {
		{'','default:clay_lump', 'default:clay_lump'},
		{'','default:clay_lump', 'default:clay_lump'},
		{'','', ''},

	}
})

minetest.register_craft({
	output = 'default:clay_lump 4',
	recipe = {
		{'default:clay'},
	}
})

minetest.register_craft({
	output = 'default:brick',
	recipe = {
		{'','default:clay_brick', 'default:clay_brick'},
		{'','default:clay_brick', 'default:clay_brick'},
		{'','', ''},

	}
})

minetest.register_craft({
	output = 'default:clay_brick 4',
	recipe = {
		{'default:brick'},
	}
})
--[[
minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})
--]]
minetest.register_craft({
	output = 'default:book',
	recipe = {
		{'default:paper'},
		{'default:paper'},
		{'default:paper'},
	}
})

minetest.register_craft({
	output = 'default:bookshelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:bookshelf',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'default:ladder_wood 3',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:ladder_steel 15',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal 9',
	recipe = {
		{'default:mese'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment 9',
	recipe = {
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:meselamp 1',
	recipe = {
		{'', 'default:mese_crystal',''},
		{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:obsidian_shard 9',
	recipe = {
		{'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:obsidianbrick 4',
	recipe = {
		{'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:stonebrick 4',
	recipe = {
		{'default:stone', 'default:stone'},
		{'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stonebrick 4',
	recipe = {
		{'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:snowblock',
	recipe = {
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
	}
})

minetest.register_craft({
	output = 'default:snow 9',
	recipe = {
		{'default:snowblock'},
	}
})

--
-- Crafting (tool repair)
--
minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "default:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "default:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:gold_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "default:clay_lump",
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:papyrus",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:ladder_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:lava_source",
	burntime = 60,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:torch",
	burntime = 4,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:sign_wall_wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest_locked",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:nyancat",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:nyancat_rainbow",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:apple",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:grass_1",
	burntime = 2,
})


-- following codes is from Hades GAME,and some tweak

minetest.register_craft({
	output = 'farming:flowergrass',
	recipe = {
		{'flowers:dandelion_white', 'flowers:dandelion_yellow', 'flowers:geranium'},
		{'flowers:rose', 'flowers:tulip', 'flowers:viola'},
		{'default:grass_1', 'default:dirt', 'default:grass_1'},
	}
})

minetest.register_craft({
	output = 'farming:seed_tomato',
	recipe = {{'farming:tomato'},}
})

minetest.register_craft({
	output = 'farming:seed_strawberry',
	recipe = {{'farming:strawberry'},}
})

minetest.register_craft({
	output = 'farming:seed_potato',
	recipe = {{'farming:potato'},}
})

minetest.register_craft({
	output = 'farming:seed_spice',
	recipe = {{'farming:spice'},}
})

minetest.register_craft({
	output = 'default:nails 24',
	recipe = {{'default:steel_ingot'},}
})

-- gemtransform
minetest.register_craft({
	output = 'default:emerald 2',
	recipe = {{'default:sapphire'},}
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:sapphire',
	recipe = {'default:emerald', 'default:emerald'},
})

minetest.register_craft({
	output = 'default:sapphire 2',
	recipe = {{'default:ruby'},}
})

minetest.register_craft({
	output = 'default:ruby 2',
	recipe = {{'default:diamond'},}
})

minetest.register_craft({
	output = 'default:diamond',
	recipe = {{'default:ruby', 'default:ruby'},}
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:ruby',
	recipe = {'default:sapphire', 'default:sapphire'},
})

--[[
minetest.register_craft({
	output = 'default:dirt 3',
	recipe = {
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'group:leaves', 'group:leaves', 'group:leaves'},
	}
})
minetest.register_craft({
    type = "shapeless",
	output = 'default:desert_sand 2',
	recipe = {'default:cobble', 'default:sand'},
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:desert_sand 2',
	recipe = {'default:mossycobble', 'default:sand'},
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:desert_sand 2',
	recipe = {'default:tuff', 'default:sand'},
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:desert_sand 2',
	recipe = {'default:mossytuff', 'default:sand'},
})

--]]

minetest.register_craft({
	output = 'default:grass_1',
	recipe = {
	    {'default:mossycobble', '', ''},
		{'default:mossycobble', '', ''},
		{'default:dirt', '', ''},
	}
})

--[[
minetest.register_craft({
	output = 'default:grass_1',
	recipe = {
	    {'default:mossytuff', '', ''},
		{'default:mossytuff', '', ''},
		{'default:dirt', '', ''},
	}
})
--]]

minetest.register_craft({
	output = 'default:junglegrass',
	recipe = {
		{'default:grass_1', '', ''},
		{'default:dirt', '', ''},
	}
})

--[[
minetest.register_craft({
	output = 'default:papyrus',
	recipe = {
		{'default:junglegrass', '', ''},
		{'default:dirt', '', ''},
	}
})
--]]

minetest.register_craft({
	output = 'default:cactus',
	recipe = {
		{'', 'default:papyrus', ''},
		{'group:sand', 'default:dirt', 'group:sand'},
	}
})

--[[
minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'default:cactus', '', ''},
		{'default:dirt', '', ''},
	}
})


minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'default:apple', '', ''},
		{'default:dirt', '', ''},
	}
})
--]]

minetest.register_craft({
	output = 'farming_plus:pale_sapling',
	recipe = {
		{'', 'default:sapling', ''},
		{'', 'default:sapling', ''},
		{'default:sand', 'default:dirt', 'default:sand'},
	}
})

minetest.register_craft({
	output = 'farming_plus:cjsapling',
	recipe = {
		{'', 'default:junglesapling', ''},
		{'', 'default:junglesapling', ''},
		{'', 'default:dirt', ''},
	}
})

minetest.register_craft({
	output = 'default:junglesapling',
	recipe = {
		{'default:sapling', '', ''},
		{'default:junglegrass', '', ''},
		{'default:dirt', '', ''},
	}
})

minetest.register_craft({
	output = 'farming_plus:olive_sapling',
	recipe = {
		{'default:sapling', '', ''},
		{'default:grass_1', '', ''},
		{'default:dirt', '', ''},
	}
})

minetest.register_craft({
	output = 'farming_plus:olive_sapling',
	recipe = {
		{'farming_plus:olive', '', ''},
		{'default:dirt', '', ''},
	}
})

minetest.register_craft({
	output = 'farming_plus:birch_sapling',
	recipe = {
		{'default:sapling', '', ''},
		{'farming_plus:pale_sapling', '', ''},
		{'default:dirt', '', ''},
	}
})

-- HadesFood

--[[
minetest.register_craftitem("default:sugar", {
	description = "Sugar",
	inventory_image = "default_sugar.png",
                     on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = 'default:sugar',
	recipe = {
		{'default:sugarcane', 'default:sugarcane', 'default:sugarcane'},
	}
})


minetest.register_craftitem("default:pie_strawberry_raw", {
	description = "StrawberryPie -- Raw (+3)",
	inventory_image = "default_strawberry_pie_raw.png",
                     on_use = minetest.item_eat(3),
})

minetest.register_craftitem("default:pie_strawberry", {
	description = "StrawberryPie (+5)",
	inventory_image = "default_strawberry_pie.png",
                     on_use = minetest.item_eat(5),
})

minetest.register_craft({
	output = 'default:pie_strawberry_raw',
	recipe = {
		{'', 'default:sugar', ''},
        {'farming:strawberry', 'farming:strawberry', 'farming:strawberry'},
        {'default:sugar', 'farming:flour', 'default:sugar'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:pie_strawberry",
	recipe = "default:pie_strawberry_raw",
	cooktime = 10,
})

minetest.register_craftitem("default:pie_apple_raw", {
	description = "ApplePie -- Raw (+3)",
	inventory_image = "default_apple_pie_raw.png",
                     on_use = minetest.item_eat(3),
})

minetest.register_craftitem("default:pie_apple", {
	description = "ApplePie (+5)",
	inventory_image = "default_apple_pie.png",
                     on_use = minetest.item_eat(5),
})


minetest.register_craft({
	output = 'default:pie_apple_raw',
	recipe = {
		{'', 'default:sugar', ''},
        {'default:apple', 'default:apple', 'default:apple'},
        {'default:sugar', 'farming:flour', 'default:sugar'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:pie_apple",
	recipe = "default:pie_apple_raw",
	cooktime = 10,
})


minetest.register_craftitem("default:bottle_olive_oil", {
	description = "Bottle of Oliveoil  (+2)",
	inventory_image = "default_bottle_olive_oil.png",
    on_use = minetest.item_eat(2),
})


minetest.register_craft({
	output = 'default:bottle_olive_oil',
	recipe = {
		{'farming_plus:olive', 'farming_plus:olive', 'farming_plus:olive'},
        {'', 'vessels:glass_bottle', ''},
	}
})

minetest.register_craftitem("default:tomatosalad", {
	description = "Tomatosalad  (+6)",
	inventory_image = "default_tomatosalad.png",
    on_use = minetest.item_eat(6),
})


minetest.register_craft({
	output = 'default:tomatosalad 2',
	recipe = {
	    {'farming:spice', 'default:bottle_olive_oil', 'farming:spice'},
		{'farming:tomato', 'farming:tomato', 'farming:tomato'},
		{'default:plate', 'farming:bread', 'default:plate'},
	}
})

minetest.register_craftitem("default:tomato_potato_salad", {
	description = "Tomato-Potato Salad  (+8)",
	inventory_image = "default_tpsalad.png",
    on_use = minetest.item_eat(8),
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:tomato_potato_salad',
	recipe = {'default:tomatosalad', 'default:baked_potato'},
})

minetest.register_craftitem("default:spiced_potato", {
	description = "Spiced-Potato (+0)",
	inventory_image = "default_spiced_potato.png",
    on_use = minetest.item_eat(0),
})

minetest.register_craft({
    type = "shapeless",
	output = 'default:spiced_potato',
	recipe = {'farming:spice', 'farming:potato'},
})

minetest.register_craftitem("default:baked_potato", {
	description = "Baked-Potato (+4)",
	inventory_image = "default_baked_potato.png",
    on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "default:baked_potato",
	recipe = "default:spiced_potato",
})

--]]

minetest.register_craft({
	output = 'default:plate 10',
	recipe = {
		{'', 'default:clay', ''},
        {'default:clay', 'default:clay', 'default:clay'},
		{'', 'default:clay', ''},
	}
})


-- New Bricks

minetest.register_craft({
	output = 'default:cactus_block',
	recipe = {
		{'default:cactus', 'default:cactus', 'default:cactus'},
		{'default:cactus', 'default:cactus', 'default:cactus'},
		{'default:cactus', 'default:cactus', 'default:cactus'},
	}
})

--[[
minetest.register_craft({
	output = 'default:cactus 9',
	recipe = {
		{'default:cactus_block'},
	}
})
--]]

minetest.register_craft({
	output = 'default:cactus_brick 4',
	recipe = {
		{'default:cactus', 'default:cactus'},
		{'default:cactus', 'default:cactus'},
	}
})

minetest.register_craft({
	output = 'default:obsidianbrick 4',
	recipe = {
		{'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian'}
	}
})


minetest.register_craft({
	output = 'default:chondrit_brick 4',
	recipe = {
		{'default:chondrit', 'default:chondrit'},
		{'default:chondrit', 'default:chondrit'},
	}
})

minetest.register_craft({
	output = 'default:essexit_brick 4',
	recipe = {
		{'default:essexit', 'default:essexit'},
		{'default:essexit', 'default:essexit'},
	}
})

minetest.register_craft({
	output = 'default:marble_brick 4',
	recipe = {
		{'default:marble', 'default:marble'},
		{'default:marble', 'default:marble'},
	}
})

minetest.register_craft({
	output = 'default:tuff_brick 4',
	recipe = {
		{'default:tuff', 'default:tuff'},
		{'default:tuff', 'default:tuff'},
	}
})

minetest.register_craft({
	output = 'default:tuff_baked_brick 4',
	recipe = {
		{'default:tuff_baked', 'default:tuff_baked'},
		{'default:tuff_baked', 'default:tuff_baked'},
	}
})
-- floors

minetest.register_craft({
	output = 'default:floor_chondrit_stone 4',
	recipe = {
		{'default:stone', 'default:chondrit'},
		{'default:chondrit', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:floor_chondrit_stone2 4',
	recipe = {
		{'default:chondrit', 'default:stone'},
		{'default:stone', 'default:chondrit'},
	}
})

minetest.register_craft({
	output = 'default:floor_bstone_stone 4',
	recipe = {
		{'default:stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:floor_btuff_tuff 4',
	recipe = {
		{'default:tuff', 'default:tuff_baked'},
		{'default:tuff_baked', 'default:tuff'},
	}
})

minetest.register_craft({
	output = 'default:floor_bstone_sandstone 4',
	recipe = {
		{'default:desert_stone', 'default:sandstone'},
		{'default:sandstone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:floor_bstone_sandstone2 4',
	recipe = {
		{'default:sandstone', 'default:desert_stone'},
		{'default:desert_stone', 'default:sandstone'},
	}
})

minetest.register_craft({
	output = 'default:floor_marble_essexit 4',
	recipe = {
		{'default:marble', 'default:essexit'},
		{'default:essexit', 'default:marble'},
	}
})

minetest.register_craft({
	output = 'default:floor_marble_essexit2 4',
	recipe = {
		{'default:essexit', 'default:marble'},
		{'default:marble', 'default:essexit'},
	}
})

minetest.register_craft({
	output = 'default:floor_essexit_gold 3',
	recipe = {
		{'default:essexit', 'default:essexit'},
		{'default:essexit', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:floor_essexit_gold2 3',
	recipe = {
		{'default:gold_ingot', 'default:essexit'},
		{'default:essexit', 'default:essexit'},
	}
})

minetest.register_craft({
	output = 'default:floor_wood_jungle 4',
	recipe = {
		{'default:wood', 'default:junglewood'},
		{'default:junglewood', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'default:floor_wood_pale 4',
	recipe = {
		{'default:wood', 'default:palewood'},
		{'default:palewood', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'default:floor_pale_jungle 4',
	recipe = {
		{'default:junglewood', 'default:palewood'},
		{'default:palewood', 'default:junglewood'},
	}
})

-- Color Bricks

minetest.register_craft({
	output = 'default:brick_black',
	recipe = {
		{'group:claybricks', 'dye:black'},
	}
})

minetest.register_craft({
	output = 'default:brick_blue',
	recipe = {
		{'group:claybricks', 'dye:blue'},
	}
})

minetest.register_craft({
	output = 'default:brick_brown',
	recipe = {
		{'group:claybricks', 'dye:brown'},
	}
})

minetest.register_craft({
	output = 'default:brick_cyan',
	recipe = {
		{'group:claybricks', 'dye:cyan'},
	}
})

minetest.register_craft({
	output = 'default:brick_dark_green',
	recipe = {
		{'group:claybricks', 'dye:dark_green'},
	}
})

minetest.register_craft({
	output = 'default:brick_dark_grey',
	recipe = {
		{'group:claybricks', 'dye:dark_grey'},
	}
})

minetest.register_craft({
	output = 'default:brick_green',
	recipe = {
		{'group:claybricks', 'dye:green'},
	}
})

minetest.register_craft({
	output = 'default:brick_grey',
	recipe = {
		{'group:claybricks', 'dye:grey'},
	}
})

minetest.register_craft({
	output = 'default:brick_magenta',
	recipe = {
		{'group:claybricks', 'dye:magenta'},
	}
})

minetest.register_craft({
	output = 'default:brick_orange',
	recipe = {
		{'group:claybricks', 'dye:orange'},
	}
})

minetest.register_craft({
	output = 'default:brick_pink',
	recipe = {
		{'group:claybricks', 'dye:pink'},
	}
})

minetest.register_craft({
	output = 'default:brick_red',
	recipe = {
		{'group:claybricks', 'dye:red'},
	}
})

minetest.register_craft({
	output = 'default:brick_violet',
	recipe = {
		{'group:claybricks', 'dye:violet'},
	}
})

minetest.register_craft({
	output = 'default:brick_white',
	recipe = {
		{'group:claybricks', 'dye:white'},
	}
})

minetest.register_craft({
	output = 'default:brick_yellow',
	recipe = {
		{'group:claybricks', 'dye:yellow'},
	}
})

-- Colored Wood

minetest.register_craft({
	output = 'default:colwood_black',
	recipe = {
		{'group:wood', 'dye:black'},
	}
})

minetest.register_craft({
	output = 'default:colwood_blue',
	recipe = {
		{'group:wood', 'dye:blue'},
	}
})

minetest.register_craft({
	output = 'default:colwood_brown',
	recipe = {
		{'group:wood', 'dye:brown'},
	}
})

minetest.register_craft({
	output = 'default:colwood_cyan',
	recipe = {
		{'group:wood', 'dye:cyan'},
	}
})

minetest.register_craft({
	output = 'default:colwood_dark_green',
	recipe = {
		{'group:wood', 'dye:dark_green'},
	}
})

minetest.register_craft({
	output = 'default:colwood_dark_grey',
	recipe = {
		{'group:wood', 'dye:dark_grey'},
	}
})

minetest.register_craft({
	output = 'default:colwood_green',
	recipe = {
		{'group:wood', 'dye:green'},
	}
})

minetest.register_craft({
	output = 'default:colwood_grey',
	recipe = {
		{'group:wood', 'dye:grey'},
	}
})

minetest.register_craft({
	output = 'default:colwood_magenta',
	recipe = {
		{'group:wood', 'dye:magenta'},
	}
})

minetest.register_craft({
	output = 'default:colwood_orange',
	recipe = {
		{'group:wood', 'dye:orange'},
	}
})

minetest.register_craft({
	output = 'default:colwood_pink',
	recipe = {
		{'group:wood', 'dye:pink'},
	}
})

minetest.register_craft({
	output = 'default:colwood_red',
	recipe = {
		{'group:wood', 'dye:red'},
	}
})

minetest.register_craft({
	output = 'default:colwood_violet',
	recipe = {
		{'group:wood', 'dye:violet'},
	}
})

minetest.register_craft({
	output = 'default:colwood_white',
	recipe = {
		{'group:wood', 'dye:white'},
	}
})

minetest.register_craft({
	output = 'default:colwood_yellow',
	recipe = {
		{'group:wood', 'dye:yellow'},
	}
})

-- Colored fences

minetest.register_craft({
	output = 'default:fence_wood_black',
	recipe = {
		{'group:woodfence', 'dye:black'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_blue',
	recipe = {
		{'group:woodfence', 'dye:blue'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_brown',
	recipe = {
		{'group:woodfence', 'dye:brown'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_cyan',
	recipe = {
		{'group:woodfence', 'dye:cyan'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_dark_green',
	recipe = {
		{'group:woodfence', 'dye:dark_green'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_dark_grey',
	recipe = {
		{'group:woodfence', 'dye:dark_grey'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_green',
	recipe = {
		{'group:woodfence', 'dye:green'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_grey',
	recipe = {
		{'group:woodfence', 'dye:grey'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_magenta',
	recipe = {
		{'group:woodfence', 'dye:magenta'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_orange',
	recipe = {
		{'group:woodfence', 'dye:orange'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_pink',
	recipe = {
		{'group:woodfence', 'dye:pink'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_red',
	recipe = {
		{'group:woodfence', 'dye:red'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_violet',
	recipe = {
		{'group:woodfence', 'dye:violet'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_white',
	recipe = {
		{'group:woodfence', 'dye:white'},
	}
})

minetest.register_craft({
	output = 'default:fence_wood_yellow',
	recipe = {
		{'group:woodfence', 'dye:yellow'},
	}
})


minetest.register_craft({
	output = 'default:lamp_ceiling 2',
	recipe = {
		{'default:glass', 'default:torch', 'default:glass'},
	}
})

minetest.register_craft({
	output = 'default:lamp_wall 2',
	recipe = {
		{'default:glass', '', ''},
		{'default:torch', '', ''},
		{'default:glass', '', ''},
	}
})

minetest.register_craft({
	output = 'default:lamp_column 2',
	recipe = {
		{'default:torch', 'default:glass', ''},
		{'default:glass', '', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'default:latern 2',
	recipe = {
		{'', 'default:bronze_ingot', ''},
		{'default:glass', 'default:torch', 'default:glass'},
		{'', 'default:bronze_ingot', ''},
	}
})

minetest.register_craft({
	output = 'default:laternrusty 2',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:glass', 'default:torch', 'default:glass'},
		{'', 'default:steel_ingot', ''},
	}
})
