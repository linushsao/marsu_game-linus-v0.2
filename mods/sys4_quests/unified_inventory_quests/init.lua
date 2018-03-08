-- unified_inventory Quests
-- By Sys4

-- This mod add quests based on unified_inventory mod

if minetest.get_modpath("minetest_quests")
   and minetest.get_modpath("unified_inventory") then
   
   local S
   if minetest.get_modpath("intllib") then
      S = intllib.Getter()
   else
      S = function(s) return s end
   end
   
   local ins = table.insert
   local up = sys4_quests.updateQuest
   
   ---------- Quests for unified_inventory mod ----------
   local mod = "unified_inventory"
   local quests = sys4_quests.initQuests(mod, S)
   
   ----- Quests with type="dig" -----
   local t = "craft"

   -- textile_worker
   ins(quests, {
	  'textile_worker', "Textile Worker", "wools", {"wool:white", "wool:black", "wool:blue", "wool:orange", "wool:red", "wool:violet", "wool:yellow", "wool:brown", "wool:cyan", "wool:dark_green", "wool:dar_grey", "wool:green", "wool:grey", "wool:magenta", "wool:pink"}, 6, {mod..":bag_small"}, "cotton_digger", type = t
	       })

   -- bag_crafter
   ins(quests, {
	  'bag_crafter', "Bag Crafter", nil, {mod..":bag_small"}, 2, {mod..":bag_medium"}, "textile_worker", type = t, custom_level = true
	       })

   -- bag_crafter_lover
   ins(quests, {
	  'bag_crafter_lover', "Bag Crafter Lover", nil, {mod..":bag_medium"}, 2, {mod..":bag_large"}, "bag_crafter", type = t, custom_level = true
	       })

   sys4_quests.registerQuests()

end
