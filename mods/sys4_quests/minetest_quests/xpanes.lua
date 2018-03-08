local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for xpanes mod ----------
local mod = "xpanes"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

-- Update quests from default
up('glass_builder', nil, {mod..":pane"})

up('iron_digger_expert', nil, {mod..":bar"})


