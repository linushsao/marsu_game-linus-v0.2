-- Minimal Exemple with Intllib support

-- For this example, suppose that global level is set to 10 (the global level is set in sys4_quests/init.lua).

-- Intllib Initialisation
local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end


-- Get Variable for register your quests
local myQuests = sys4_quests.initQuests("myMod", S)

--[[ Define groups of quests (optional)
   - Quests inside a group must be all finished before the next group of quests start. (If any)
   - If some quests are not defined to be inside a group then they are automaticaly included in a 'global' group.
   - The quests inside the 'global' group are playables in parallel to other group of quests.
--]]
local wood_g = "Wood Group"
local mese_g = "Mese Group"
sys4_quests.addQuestGroup(wood_g) -- Add this group as the first
sys4_quests.addQuestGroup(mese_g) -- Add this group as the second...

-- Setting your quests --

-- First quest in "Wood Group" : Dig 10 default:acacia_tree that will unlock craft of default:acacia_wood, default:stick, myMod:axe_acacia, myMod:sword_acacia
table.insert(myQuests, {
		       'acacia_digger', -- Quest name
		       "Acacia Digger", -- Quest Title	
		       nil,    		-- Custom Description (not set here)
		       {'default:acacia_tree'}, -- List of target nodes for increment counter of this quest (1 target node here)
		       1,			-- Target node counter that would be reached for finish the quest (keep in mind that this target counter will be multiplied by the global level)
		       {'default:acacia_wood', 'default:stick', 'myMod:axe_acacia', 'myMod:sword_acacia'}, -- Unlocked items ready to craft when quest is finished
		       nil,		       -- Parent quest name if this quest depends on it (none here, because it's the first quest)
		       type = 'dig'	       -- Type of the quest (there is 3 existing types for now : 'dig', 'craft', 'place')
		       group = wood_g          -- Set the group property with the right group
		       })

-- Second quest in "Wood Group" : Craft 2 acacia tools that will unlock craft of myMod:magical_wand
table.insert(myQuest, {
		      'acacia_crafter',
		      "Acacia Tools Crafter",
		      "Acacia Tools",		-- Custom Desc is set here (In game this will be displayed as this : "Craft 2 Acacia Tools")
		      {'myMod:axe_acacia', 'myMod:sword_acacia'}, -- Exemple of multiple target nodes
		      2,
		      {'myMod:magical_wand'},
		      'acacia_digger',		-- Parent quest is defined here, so that quest will be displayed only when its parent quest will be finished.
		                                -- Parent quest must be in the same group of this quest.
		      type = 'craft',
		      custom_level = true       -- Set this attribute to 'true' if you want the target node counter must not be affected by the global level.
		      group = wood_g            -- Set the group property whith the right group.
		      })

-- First quest in "Mese Group" : Dig 20 stones with mese that will unlock craft of default:mese (Mese block)
table.insert(myQuest, {
		'mese_digger',
		"Mese Digger",
		nil,
		{"default:stone_with_mese"},
		2,
		{"default:mese"},
		nil, -- No parent quest defined because this is the first quest of the "Mese Group".
		type = "dig",
		group = mese_g
		      })

-- [...]

-- Quest in "global" group (in no groups in fact) : Dig 20 stones with diamond that will unlock craft of default:diamondblock
table.insert(myQuest, {
		'diamond_digger',
		"Diamond Digger",
		nil,
		{"default:stone_with_diamond"},
		2,
		{"default:diamondblock"},
		"iron_pick_crafter|bronze_pick_crafter", -- Example of multiple parent quests. Here, at least one of the two parent quests must be finished for display this quest. (OR)
		                                         -- You can use more than 2 parents quests.
		                                         -- Because this quest is not in a group (so in 'global') then parent quests can be inside whatever groups.
		type = "dig"
		      })

-- Another quest in "global" group : Dig 10 stones with copper that will unlock craft of default:bronze_ingot
table.insert(myQuest, {
		'bronze_age',
		"Bronze Age",
		nil,
		{"default:stone_with_copper"},
		1,
		{"default:bronze_ingot"},
		{"furnace_crafter", "iron_digger"}, -- Another exemple of multiple parent quests. Here, the two parent quests must be finished for display this quest. (AND)
		                                    -- You can use more than 2 parents quests and mix them as this : {"furnace_crafter", "iron_digger|tin_digger"}
		type = "dig"
		      })

-- You can update a previously made quest by another mod as this :
if minetest.get_modpath("minetest_quests") then
   
   sys4_quest.updateQuest('tools_crafter',		-- Name of a previously created quest in "minetest_quests" mod.
	{'myMod:axe_acacia', 'myMod:sword_acacia'},	-- Update Target Nodes/Items of this quests with your nodes/items (nil is accepted)
	{'myMod:pick_acacia'}				-- Update Unlocked Nodes/items of this quests with your nodes/items (nil is accepted)
   )

end

-- CAUTION : Register your quests
sys4_quests.registerQuests()  -- This instruction is not needeed if you have only updated quests. (Not the case here)

--[[
# With intllib support you can make this entries in your locale/<lang>.txt
# Exemple :

myMod:axe_acacia = Acacia Axe
myMod:sword_acacia = Acacia Sword
myMod:magical_wand = Magical Wand
Acacia Digger = <Your Translated String>
Acacia Tools Crafter = <Idem>
Acacia Tools = <Idem>

# Your depends.txt does contain for this exemple :
default
sys4_quests
minetest_quests?

## End of Exemple ##

For more quests example, take a look at my others quests mods as :
* minetest_quests
* 3d_armor_quests
* mobs_quests
* ethereal_quests
* and more...
--]]
