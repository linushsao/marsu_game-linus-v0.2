local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for tnt mod ----------
local mod = "tnt"

----- Quests Groups -----
local stone = "Stone Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

local t = "dig"

ins(quests, {
       'gravel_digger', "Gravel Digger", nil, {"default:gravel"}, 1, {mod..":gunpowder"}, "coal_digger", type = t, group = stone
	    })

t = "craft"

ins(quests, {
       'gunpowder_crafter', "Gunpowder Crafter", nil, {mod..":gunpowder"}, 1, {mod..":tnt"}, "gravel_digger", type = t, group = stone, custom_level = true
	    })

sys4_quests.registerQuests()
