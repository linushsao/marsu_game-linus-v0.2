local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for default mod ----------
local mod = "default"

----- Quests Groups -----
local dark = "Dark Age"
local wood = "Wood Age"
local farm = "Farming Age"
local stone = "Stone Age"
local metal = "Metal Age"
local middle = "Middle Age"

sys4_quests.addQuestGroup(dark)
sys4_quests.addQuestGroup(wood)
sys4_quests.addQuestGroup(farm)
sys4_quests.addQuestGroup(stone)
sys4_quests.addQuestGroup(metal)
sys4_quests.addQuestGroup(middle)

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

----- Quests with type="dig" -----
local t = "dig"

-- snow_digger
ins(quests, {
       'snow_digger', "Snow Digger", nil, {mod..":snow"}, 9, {mod..":snowblock", mod..":snow"}, nil, type = t
	    })

-- clay_digger
ins(quests, {
       'clay_digger', "Clay Digger", nil, {mod..":clay"}, 1, {mod..":clay", mod..":clay_lump"}, nil, type = t, group = dark
	    })

-- papyrus_digger
ins(quests, {
       'papyrus_digger', "Papyrus Digger", nil, {mod..":papyrus"}, 3, {mod..":paper"}, nil, type = t, group = farm
	    })

-- sand_digger
ins(quests, {
       'sand_digger', "Sand Digger", nil, {mod..":sand", mod..":desert_sand"}, 4, {mod..":sandstone", mod..":sand"}, nil, type = t, group = dark
	    })

-- tree_digger
ins(quests, {
       'tree_digger', "Tree Digger", nil, {mod..":tree", mod..":jungletree", mod..":acacia_tree", mod..":pine_tree", mod..":aspen_tree"}, 1, {mod..":wood", mod..":junglewood", mod..":acacia_wood", mod..":pine_wood", mod..":aspen_wood"}, nil, type = t, group = dark
	    })

-- coal_digger
ins(quests, {
       'coal_digger', "Coal Digger", nil, {mod..":stone_with_coal"}, 1, {mod..":torch"}, nil, type = t, custom_level = true, group = stone
	    })

-- coal_digger_lover
ins(quests, {
       'coal_digger_lover', "Coal Digger Lover", nil, {mod..":stone_with_coal"}, 8, {mod..":coalblock", mod..":coal_lump"}, "coal_digger", type = t, group = stone
	    })

-- stone_digger
ins(quests, {
       'stone_digger', "Stone Digger", nil, {mod..":stone", mod..":desert_stone", mod..":cobble", mod..":desert_cobble", mod..":mossycobble", mod..":stonebrick", mod..":desert_stonebrick"}, 1, {mod..":shovel_stone"}, nil, type = t, group = stone
	    })

-- stone_digger_lover
ins(quests, {
       'stone_digger_lover', "Stone Digger Lover", nil, {mod..":stone", mod..":desert_stone", mod..":cobble", mod..":desert_cobble", mod..":mossycobble", mod..":stonebrick", mod..":desert_stonebrick"}, 1, {mod..":sword_stone"}, "stone_digger", type = t, group = stone
	    })

-- stone_digger_pro
ins(quests, {
       'stone_digger_pro', "Stone Digger Pro", nil, {mod..":stone", mod..":desert_stone", mod..":cobble", mod..":desert_cobble", mod..":mossycobble", mod..":stonebrick", mod..":desert_stonebrick"}, 1, {mod..":pick_stone", mod..":axe_stone"}, "stone_digger_lover", type = t, group = stone
	    })

-- stone_digger_expert
ins(quests, {
       'stone_digger_expert', "Stone Digger Expert", nil, {mod..":stone", mod..":desert_stone", mod..":cobble", mod..":desert_cobble", mod..":mossycobble", mod..":stonebrick", mod..":desert_stonebrick"}, 5, {mod..":furnace"}, "stone_digger_pro", type = t, group = stone
	    })

-- copper_digger
ins(quests, {
       'copper_digger', "Copper Digger", nil, {mod..":stone_with_copper"}, 9, {mod..":copperblock", mod..":copper_ingot"}, nil, type = t, group = metal
	    })

-- bronze_discover
if minetest.get_modpath("moreores") then
   ins(quests, {
	  'bronze_discover', "Bronze Discover", nil, {mod..":stone_with_copper"}, 1, {mod..":bronze_ingot"}, "iron_digger|tin_digger", type = t, group = metal
	       })
else
   ins(quests, {
	  'bronze_discover', "Bronze Discover", nil, {mod..":stone_with_copper"}, 1, {mod..":bronze_ingot"}, "iron_digger", type = t, group = metal
	       })
end

-- iron_digger
ins(quests, {
       'iron_digger', "Iron Digger", nil, {mod..":stone_with_iron"}, 1, {mod..":shovel_steel", mod..":chest_locked"}, nil, type = t, group = metal
	    })

-- iron_digger_lover
ins(quests, {
       'iron_digger_lover', "Iron Digger Lover", nil, {mod..":stone_with_iron"}, 1, {mod..":sword_steel"}, "iron_digger", type = t, group = metal
	    })

-- iron_digger_pro
ins(quests, {
       'iron_digger_pro', "Iron Digger Pro", nil, {mod..":stone_with_iron"}, 1, {mod..":pick_steel", mod..":axe_steel"}, "iron_digger_lover", type = t, group = metal
	    })

-- iron_digger_expert
ins(quests, {
       'iron_digger_expert', "Iron Digger Expert", nil, {mod..":stone_with_iron"}, 3, {mod..":sign_wall_steel", mod..":rail"}, "iron_digger_pro", type = t, group = metal
	    })

-- iron_digger_master
ins(quests, {
       'iron_digger_master', "Iron Digger Master", nil, {mod..":stone_with_iron"}, 1, {mod..":ladder_steel"}, "iron_digger_expert", type = t, group = metal
	    })

-- iron_digger_god
ins(quests, {
       'iron_digger_god', "Iron Digger God", nil, {mod..":stone_with_iron"}, 2, {mod..":steelblock", mod..":steel_ingot"}, "iron_digger_master", type = t, group = metal
	    })

-- gold_digger
ins(quests, {
       'gold_digger', "Gold Digger", nil, {mod..":stone_with_gold"}, 9, {mod..":goldblock", mod..":gold_ingot"}, nil, type = t, group = metal
	    })

-- mese_digger
ins(quests, {
       'mese_digger', "Mese Digger", nil, {mod..":stone_with_mese"}, 1, {mod..":mese_crystal_fragment", mod..":shovel_mese"}, nil, type = t, group = middle
	    })

-- mese_digger_lover
ins(quests, {
       'mese_digger_lover', "Mese Digger Lover", nil, {mod..":stone_with_mese"}, 1, {mod..":sword_mese"}, "mese_digger", type = t, group = middle
	    })

-- mese_digger_pro
ins(quests, {
       'mese_digger_pro', "Mese Digger Pro", nil, {mod..":stone_with_mese"}, 1, {mod..":pick_mese", mod..":axe_mese", mod..":meselamp"}, "mese_digger_lover", type = t, group = middle
	    })

-- mese_digger_expert
ins(quests, {
       'mese_digger_expert', "Mese Digger Expert", nil, {mod..":stone_with_mese"}, 6, {mod..":mese", mod..":mese_crystal"}, "mese_digger_pro", type = t, group = middle
	    })

-- diamond_digger
ins(quests, {
       'diamond_digger', "Diamond Digger", nil, {mod..":stone_with_diamond"}, 1, {mod..":shovel_diamond"}, nil, type = t, group = middle
	    })

-- diamond_digger_lover
ins(quests, {
       'diamond_digger_lover', "Diamond Digger Lover", nil, {mod..":stone_with_diamond"}, 1, {mod..":sword_diamond"}, "diamond_digger", type = t, group = middle
	    })

-- diamond_digger_pro
ins(quests, {
       'diamond_digger_pro', "Diamond Digger Pro", nil, {mod..":stone_with_diamond"}, 1, {mod..":pick_diamond", mod..":axe_diamond"}, "diamond_digger_lover", type = t, group = middle
	    })

-- diamond_digger_expert
ins(quests, {
       'diamond_digger_expert', "Diamond Digger Expert", nil, {mod..":stone_with_diamond"}, 6, {mod..":diamondblock", mod..":diamond"}, "diamond_digger_pro", type = t, group = middle
	    })

-- obsidian_digger
ins(quests, {
       'obsidian_digger', "Obsidian Digger", nil, {mod..":obsidian"}, 1, {mod..":obsidian_shard"}, nil, type = t, group = middle
	    })

-- obsidian_digger_lover
ins(quests, {
       'obsidian_digger_lover', "Obsidian Digger Lover", nil, {mod..":obsidian"}, 3, {mod..":obsidianbrick"}, "obsidian_digger", type = t, group = middle
	    })

----- Quests with type="place" -----
t = "place"

-- sandstone_builder
ins(quests, {
       'sandstone_builder', "Sandstone Builder", nil, {mod..":sandstone"}, 3, {"stairs:slab_sandstone", "stairs:stair_sandstone"}, "wood_crafter", type = t
	    })

-- wood_builder
ins(quests, {
       'wood_builder', "Wood Builder", nil, {mod..":wood", mod..":junglewood", mod..":acacia_wood", mod..":pine_wood", mod..":aspen_wood"}, 3, {"stairs:slab_wood", "stairs:stair_wood","stairs:slab_junglewood", "stairs:stair_junglewood","stairs:slab_acacia_wood", "stairs:stair_acacia_wood","stairs:slab_pine_wood", "stairs:stair_pine_wood","stairs:slab_aspen_wood", "stairs:stair_aspen_wood"}, nil, type = t, group = wood
	    })

-- sandstonebrick_builder
ins(quests, {
       'sandstonebrick_builder', "Sandstone Bricks Builder", nil, {mod..":sandstonebrick"}, 3, {"stairs:slab_sandstonebrick", "stairs:stair_sandstonebrick"}, "sandstone_crafter", type = t, group = stone
	    })

-- stone_builder
ins(quests, {
       'stone_builder', "Stone Builder", nil, {mod..":stone", mod..":desert_stone"}, 3, {"stairs:slab_stone", "stairs:stair_stone", "stairs:slab_desert_stone", "stairs:stair_desert_stone"}, "furnace_crafter", type = t
	    })

-- brick_builder
ins(quests, {
       'brick_builder', "Brick Builder", nil, {mod..":brick"}, 3, {"stairs:slab_brick", "stairs:stair_brick"}, "furnace_crafter", type = t, group = stone
	    })

--stonebrick_builder
ins(quests, {
       'stonebrick_builder', "Stone Brick Builder", nil, {mod..":stonebrick", mod..":desert_stonebrick"}, 3, {"stairs:slab_stonebrick", "stairs:stair_stonebrick", "stairs:slab_desert_stonebrick", "stairs:stair_desert_stonebrick"}, "furnace_crafter", type = t, group = stone
	    })

-- cobble_builder
ins(quests, {
       'cobble_builder', "Cobble Builder", nil, {mod..":cobble", mod..":desert_cobble"}, 3, {"stairs:slab_cobble", "stairs:stair_cobble", "stairs:slab_desert_cobble", "stairs:stair_desert_cobble"}, nil, type = t, group = stone
	    })

-- copperblock_builder
ins(quests, {
       'copperblock_builder', "Copper Block Builder", nil, {mod..":copperblock"}, 3, {"stairs:slab_copperblock", "stairs:stair_copperblock"}, "copper_digger", type = t
	    })

-- bronzeblock_builder
ins(quests, {
       'bronzeblock_builder', "Bronze Block Builder", nil, {mod..":bronzeblock"}, 3, {"stairs:slab_bronzeblock", "stairs:stair_bronzeblock"}, "bronze_crafter_expert", type = t
	    })

-- steelblock_builder
ins(quests, {
       'steelblock_builder', "Steel Block Builder", nil, {mod..":steelblock"}, 3, {"stairs:slab_steelblock", "stairs:stair_steelblock"}, "iron_digger_god", type = t
	    })

-- goldblock_builder
ins(quests, {
       'goldblock_builder', "Gold Block Builder", nil, {mod..":goldblock"}, 3, {"stairs:slab_goldblock", "stairs:stair_goldblock"}, "gold_digger", type = t
	    })

-- obsidian_builder
ins(quests, {
       'obsidian_builder', "Obsidian Builder", nil, {mod..":obsidian"}, 3, {"stairs:slab_obsidian", "stairs:stair_obsidian"}, "obsidian_digger", type = t
	    })

-- obsidianbrick_builder
ins(quests, {
       'obsidianbrick_builder', "Obsidian Brick Builder", nil, {mod..":obsidianbrick"}, 3, {"stairs:slab_obsidianbrick", "stairs:stair_obsidianbrick"}, "obsidian_digger_lover", type = t
	    })

----- Quests with type="craft" -----
t = "craft"

-- paper_crafter
ins(quests, {
       'paper_crafter', "Paper Crafter", nil, {mod..":paper"}, 3, {mod..":book"}, "papyrus_digger", type = t, group = farm
	    })

-- book_crafter
ins(quests, {
       'book_crafter', "Book Crafter", nil, {mod..":book"}, 3, {mod..":bookshelf"}, "paper_crafter", type = t, group = farm
	    })

-- wood_crafter
ins(quests, {
       'wood_crafter', "Wood Crafter", nil, {mod..":wood", mod..":junglewood", mod..":acacia_wood", mod..":pine_wood", mod..":aspen_wood"}, 4, {mod..":stick", mod..":sword_wood", mod..":axe_wood", mod..":shovel_wood"}, nil, type = t, group = wood
	    })

-- wood_crafter_lover
ins(quests, {
       'wood_crafter_lover', "Wood Crafter Lover", nil, {mod..":wood", mod..":junglewood", mod..":acacia_wood", mod..":pine_wood", mod..":aspen_wood"}, 4, {mod..":sign_wall_wood", mod..":chest"}, "wood_crafter", type = t, group = wood
	    })

-- sticks_crafter
ins(quests, {
       'sticks_crafter', "Sticks Crafter", nil, {mod..":stick"}, 4, {mod..":fence_wood", mod..":fence_junglewood", mod..":fence_acacia_wood", mod..":fence_pine_wood", mod..":fence_aspen_wood"}, "wood_crafter", type = t, group = wood
	    })

-- sticks_crafter_lover
ins(quests, {
       'sticks_crafter_lover', "Sticks Crafter Lover", nil, {mod..":stick"}, 4, {mod..":ladder_wood"}, "sticks_crafter", type = t, group = wood
	    })

-- tools_crafter
ins(quests, {
       'tools_crafter', "Tools Crafter", "wooden tools", {mod..":sword_wood", mod..":axe_wood", mod..":shovel_wood"}, 3, {mod..":pick_wood"}, {"wood_crafter_lover", "sticks_crafter_lover"}, type = t, group = wood, custom_level = true
	    })

-- furnace_crafter
ins(quests, {
       'furnace_crafter', "Furnace Crafter", nil, {mod..":furnace"}, 1, {mod..":brick", mod..":clay_brick", mod..":stonebrick", mod..":desert_stonebrick"}, "stone_digger_expert", type = t, custom_level = true, group = stone
	    })

-- sandstone_crafter
ins(quests, {
       'sandstone_crafter', "Sandstone Crafter", nil, {mod..":sandstone"}, 4, {mod..":sandstonebrick"}, "stone_digger_pro", type = t, group = stone
	    })

-- bronze_crafter
ins(quests, {
       'bronze_crafter', "Bronze Crafter", nil, {mod..":bronze_ingot"}, 1, {mod..":shovel_bronze"}, "bronze_discover", type = t, group = metal
	    })

-- bronze_crafter_lover
ins(quests, {
       'bronze_crafter_lover', "Bronze Crafter Lover", nil, {mod..":bronze_ingot"}, 1, {mod..":sword_bronze"}, "bronze_crafter", type = t, group = metal
	    })

-- bronze_crafter_pro
ins(quests, {
       'bronze_crafter_pro', "Bronze Crafter Pro", nil, {mod..":bronze_ingot"}, 1, {mod..":pick_bronze", mod..":axe_bronze"}, "bronze_crafter_lover", type = t, group = metal
	    })

-- bronze_crafter_expert
ins(quests, {
       'bronze_crafter_expert', "Bronze Crafter Expert", nil, {mod..":bronze_ingot"}, 6, {mod..":bronzeblock"}, "bronze_crafter_pro", type = t, group = metal
	    })

-- obsidian_shard_crafter
ins(quests, {
       'obsidian_shard_crafter', "Obsidian Shard Crafter", nil, {mod..":obsidian_shard"}, 9, {mod..":obsidian"}, "obsidian_digger", type = t, group = middle
	    })

-- register quests
sys4_quests.registerQuests()
