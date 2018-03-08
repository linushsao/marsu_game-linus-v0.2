local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for walls mod ----------
local mod = "walls"

----- Quests Groups -----
local stone = "Stone Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

ins(quests, {
       'cobble_builder_lover', "Cobble Builder Lover", nil, {"default:cobble", "default:desertcobble", "default:mossycobble"}, 3, {mod..":cobble", mod..":desertcobble", mod..":mossycobble"}, "cobble_builder", type = "place", group = stone
	    })

sys4_quests.registerQuests()

