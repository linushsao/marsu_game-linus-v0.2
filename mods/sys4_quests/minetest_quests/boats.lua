local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for boats mod ----------
local mod = "boats"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

up('wood_crafter_lover', nil, {mod..":boat"})
