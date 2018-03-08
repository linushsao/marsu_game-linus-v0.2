local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- Make local shortcuts of global functions --
local ins = table.insert
local up = sys4_quests.updateQuest

---------- Quests for vessels mod ----------
local mod = "vessels"

----- Quests Groups -----
local stone = "Stone Age"
local metal = "Metal Age"

-- Get variable for register quests
local quests = sys4_quests.initQuests(mod, S)

-- Update quests from default
up('furnace_crafter', nil, {mod..":glass_bottle", mod..":drinking_glass"})

local t = "dig"

ins(quests, {
       'steel_blower', "Steel Blower", nil, {"default:stone_with_iron"}, 2, {mod..":steel_bottle"}, "iron_digger_pro", type = t, group = metal
	    })

t = "craft"

ins(quests, {
       'glass_blower', "Glass Blower", "vessels items", {mod..":glass_bottle", mod..":steel_bottle", mod..":drinking_glass"}, 3, {mod..":shelf"}, {"furnace_crafter"}, type = t, group = stone
	    })

sys4_quests.registerQuests()
