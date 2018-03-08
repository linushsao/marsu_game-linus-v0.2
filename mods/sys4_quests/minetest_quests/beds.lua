local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for beds mod ----------
local mod = "beds"

----- Quests Groups -----
local farm = "Farming Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

local t = "craft"

-- interior_decorator
ins(quests, {
       'interior_decorator', "Interior Decorator", nil, {"wool:red"}, 2, {mod..":bed_bottom", mod..":fancy_bed_bottom"}, {"wool_crafter"}, type = t, group = farm, custom_level = true
	    })

sys4_quests.registerQuests()
