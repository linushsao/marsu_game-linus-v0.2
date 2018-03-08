local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for farming mod ----------
local mod = "farming"

----- Quests Groups -----
local farm = "Farming Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

-- update quests from default
up('book_crafter', nil, {mod..":hoe_wood"})

up('stone_digger_lover', nil, {mod..":hoe_stone"})

up('iron_digger_lover', nil, {mod..":hoe_steel"})

up('bronze_crafter_lover', nil, {mod..":hoe_bronze"})

up('mese_digger_lover', nil, {mod..":hoe_mese"})

up('diamond_digger_lover', nil, {mod..":hoe_diamond"})

up('furnace_crafter', nil, {mod..":flour"})

local t = "dig"

-- wheat_digger
ins(quests, {
       'wheat_digger', "Wheat Digger", nil, {mod..":wheat_1", mod..":wheat_2", mod..":wheat_3", mod..":wheat_4", mod..":wheat_5", mod..":wheat_6", mod..":wheat_7", mod..":wheat_8"}, 9, {mod..":straw", mod..":wheat"}, "book_crafter", type = t, group = farm
	    })

t = "place"

-- straw_builder
ins(quests, {
       'straw_builder', "Straw Builder", nil, {mod..":straw"}, 3, {"stairs:slab_straw", "stairs:stair_straw"}, "wheat_digger", type = t
	    })

-- register quests
sys4_quests.registerQuests()

