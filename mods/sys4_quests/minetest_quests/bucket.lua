local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for bucket mod ----------
local mod = "bucket"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

up('iron_digger_pro', nil, {mod..":bucket_empty"})

