local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for wool mod ----------
local mod = "wool"

----- Quests Groups -----
local farm = "Farming Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

-- update quests from default
up('coal_digger', nil, {mod..":black"})

local t = "dig"

-- cotton_digger
ins(quests, {
       'cotton_digger', "Cotton Digger", nil, {"farming:cotton_1","farming:cotton_2","farming:cotton_3","farming:cotton_4","farming:cotton_5","farming:cotton_6","farming:cotton_7","farming:cotton_8"}, 4, {mod..":white"}, "book_crafter", type = t, group = farm
	    })

t = "craft"

-- wool_crafter
ins(quests, {
       'wool_crafter', "Wool Crafter", nil, {mod..":white"}, 1, {mod..":blue", mod..":orange", mod..":red", mod..":violet", mod..":yellow"}, {"cotton_digger", "flower_digger"}, type = t, group = farm
	    })

-- wool_crafter_lover
ins(quests, {
       'wool_crafter_lover', "Wool Crafter Lover", "colored wools", {mod..":white", mod..":black", mod..":blue", mod..":orange", mod..":red", mod..":violet", mod..":yellow"}, 1, {mod..":brown", mod..":cyan", mod..":dark_green", mod..":dark_grey", mod..":green", mod..":grey", mod..":magenta", mod..":pink"}, "dye_crafter", type = t
	    })

-- register quests
sys4_quests.registerQuests()
