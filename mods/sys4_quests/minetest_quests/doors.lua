local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for doors mod ----------
local mod = "doors"

----- Quests Groups -----
local dark = "Dark Age"
local wood = "Wood Age"
local farm = "Farming Age"
local stone = "Stone Age"
local metal = "Metal Age"
local middle = "Middle Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

-- update Quests from default
up('iron_digger_expert', nil, {mod..":door_steel", mod..":trapdoor_steel"})

local t = "place"

-- wood_builder_lover
ins(quests, {
       'wood_builder_lover', "Wood Builder Lover", nil, {"default:wood", "stairs:slab_wood", "stairs:stair_wood", "default:junglewood", "stairs:slab_junglewood", "stairs:stair_junglewood", "default:acacia_wood", "stairs:slab_acacia_wood", "stairs:stair_acacia_wood", "default:pine_wood", "stairs:slab_pine_wood", "stairs:stair_pine_wood", "default:aspen_wood", "stairs:slab_aspen_wood", "stairs:stair_aspen_wood"}, 3, {mod..":door_wood", mod..":trapdoor"}, "wood_builder", type = t, group = wood
	    })

-- fence_placer
ins(quests, {
       'fence_placer', "Fence Placer", nil, {"default:fence_wood", "default:fence_junglewood", "default:fence_acacia_wood", "default:fence_pine_wood", "default:fence_aspen_wood"}, 3, {mod..":gate_wood_closed", mod..":gate_junglewood_closed", mod..":gate_acacia_wood_closed", mod..":gate_pine_wood_closed", mod..":gate_aspen_wood_closed"}, "sticks_crafter", type = t, group = wood
	    })

-- glass_builder
ins(quests, {
       'glass_builder', "Glass Builder", nil, {"default:glass"}, 3, {mod..":door_glass"}, "furnace_crafter", type = t, group = stone
	    })

-- obsidian_glass_builder
ins(quests, {
       'obsidian_glass_builder', "Obsidian Glass Builder", nil, {"default:obsidian_glass"}, 3, {mod..":door_obsidian_glass"}, "obsidian_digger", type = t, group = middle
	    })

sys4_quests.registerQuests()

