-- Sys4 Quests
-- By Sys4

-- This mod provide an api that could be used by others mods for easy creation of quests.

local S
if minetest.get_modpath("intllib") then
   S = intllib.Getter()
else
   S = function(s) return s end
end

-- New Waste Node
minetest.register_node("sys4_quests:waste",
{
   description = S("Waste"),
   tiles = {"waste.png"},
   is_ground_content = false,
   groups = {crumbly=2, flammable=2},
})

local playerList = {}

sys4_quests = {}
sys4_quests.questGroups = {}
sys4_quests.questGroups['global'] = {order = 1, questsIndex = {}}

local lastQuestIndex = 0
--local level = 33
local level = 12

function sys4_quests.addQuestGroup(groupName)

   if groupName ~= nil and groupName ~= "" and groupName ~= "global" then
      local groupLen = 0
      for _, group in pairs(sys4_quests.questGroups) do
	 groupLen = groupLen + 1
      end
      sys4_quests.questGroups[groupName] = {order = groupLen + 1, questsIndex = {}}
   end
end

--[[function sys4_quests.addQuestGroupAfter(existingGroupName, groupName)
   if groupName == nil or groupName == "" or groupName == "global" then
      return
   end
   
   if not sys4_quests.questGroups or sys4_quests.questGroups == nil
   or not existingGroupName or existingGroupName == nil or existingGroupName == "" then
      sys4_quests.addQuestGroup(groupName)
   else
      local isExistingGroupPresent = false
      for i = 1, #sys4_quests.questGroups do
	 if sys4_quests.questGroups[i].name == existingGroupName then
	    
	    isExistingGroupPresent = true

	    if i == #sys4_quests.questGroups then
	       sys4_quests.addQuestsGroup(groupName)
	    else
	       for j = #sys4_quests.questGroups, i + 1, -1 do
		  sys4_quests.questGroups[j+1] = sys4_quests.questsGroups[j]
	       end
	       sys4_quests.questGroups[i+1] = {name = groupName, questsIndex = {}}
	       break
	    end
	 end
      end
      if not isExistingGroupPresent then
	 return
      end
   end
end

function sys4_quests.addQuestGroupBefore(existingGroupName, groupName)
   if groupName == nil or groupName == "" or groupName == "global" or
   not existingGroupName or existingGroupName == "" or existingGroupName == "global" then
      return
   end

   if not sys4_quests.questGroups or sys4_quests.questGroups == nil then
      sys4_quests.addQuestGroup(groupName)
   else
      local isExistingGroupPresent = false
      for i = 1, #sys4_quests.questGroups do
	 if sys4_quests.questGroups[i].name == existingGroupName then
	    
	    isExistingGroupPresent = true

	    for j = #sys4_quests.questGroups, i, -1 do
	       sys4_quests.questGroups[j+1] = sys4_quests.questsGroups[j]
	    end
	    sys4_quests.questGroups[i] = {name = groupName, questsIndex = {}}
	    break
	 end
      end
      if not isExistingGroupPresent then
	 return
      end      
   end
end
--]]

local function isQuestActive(questName, playern)
   if quests.active_quests[playern] ~= nil
   and quests.active_quests[playern]["sys4_quests:"..questName] ~= nil then
      return true
   else
      return false
   end
end

local function isQuestSuccessfull(questName, playern)
   if quests.successfull_quests[playern] ~= nil
   and quests.successfull_quests[playern]["sys4_quests:"..questName] ~= nil then
      return true
   else
      return false
   end
end

local function getGroupByQuestIndex(questIndex)
   local groupName = nil
   local isFound = false
   for name, group in pairs(sys4_quests.questGroups) do
      for _, index in ipairs(group.questsIndex) do
	 if index == questIndex and name ~= "global" then
	    groupName = name
	    isFound = true
	    break
	 end
      end
      if isFound then break end
   end

   return groupName
end

local function getActiveQuestGroup(playern)
   local groupName = nil
   local isFound = false
   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, quest in ipairs(registeredQuests.quests) do
--	 print("Quest : "..quest[1])
	 if isQuestActive(quest[1], playern) then
--	    print("is ACTIVE")
	    groupName = getGroupByQuestIndex(quest.index)
--	    print("GroupName is : "..dump(groupName))
	    if groupName ~= nil then
	       isFound = true
	       break
	    end
	 end
      end
      if isFound then break end
   end

--   print("Return groupName : "..dump(groupName))
   return groupName
end

local function getFirstQuestGroup()
   for name, group in pairs(sys4_quests.questGroups) do
--      print("NAME : "..name..", ORDER : "..group.order)
      if group.order == 2 then
	 return name
      end
   end
end

local function getQuestGroupOrder(questGroup)
   for name, group in pairs(sys4_quests.questGroups) do
      if name == questGroup then
	 return group.order
      end
   end
   return nil
end

local function getQuestGroupByGroupOrder(order)
   for name, group in pairs(sys4_quests.questGroups) do
      if group.order == order then
	 return name
      end
   end
   return nil
end

local function getNextQuestGroup(currentQuestGroup)
   local groupTotal = 0
   for _, group in pairs(sys4_quests.questGroups) do
      groupTotal = groupTotal + 1
   end

   local groupOrder = getQuestGroupOrder(currentQuestGroup)

   if groupOrder == groupTotal then
      return nil
   else
      return getQuestGroupByGroupOrder(groupOrder + 1)
   end
end

function sys4_quests.initQuests(mod, intllib)
   if not intllib or intllib == nil then
      intllib = S
   end
   
   if not sys4_quests.registeredQuests or sys4_quests.registeredQuests == nil then
      sys4_quests.registeredQuests = {}
   end

   sys4_quests.registeredQuests[mod] = {}
   sys4_quests.registeredQuests[mod].intllib = intllib
   sys4_quests.registeredQuests[mod].quests = {}
   return sys4_quests.registeredQuests[mod].quests
end

function sys4_quests.registerQuests()

   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      
      local modIntllib = registeredQuests.intllib

      -- init quests index
      for _, quest in pairs(registeredQuests.quests) do

	 -- Register quest
	 --print("Register quest : "..mod.." - "..quest[1])
	 --local auto = sys4_quests.hasDependencies(quest[1])
	 --print("Autoaccept next quest : "..dump(auto))

	 local maxlevel = quest[5] * level
	 if quest.custom_level then
	    maxlevel = quest[5]
	 end

	 --print(dump(quest))
	 
	 if quests.register_quest("sys4_quests:"..quest[1],
				  { title = modIntllib(quest[2]),
				 description = sys4_quests.formatDescription(quest, maxlevel, modIntllib),
				 max = maxlevel,
				 --autoaccept = sys4_quests.hasDependencies(quest[1]),
				 autoaccept = true,
				 callback = sys4_quests.nextQuest
			       })
	 then
	    lastQuestIndex = lastQuestIndex + 1
	    quest.index = lastQuestIndex

	    -- insert quest index in specified group
	    if not quest.group then
	       table.insert(sys4_quests.questGroups['global'].questsIndex, quest.index)
	    elseif sys4_quests.questGroups[quest.group] ~= nil then
--	       print("Insert New QuestGroup : "..quest.group)
	       table.insert(sys4_quests.questGroups[quest.group].questsIndex, quest.index)
	    end

	 elseif not quests.registered_quests["sys4_quests:"..quest[1] ].autoaccept
	 and sys4_quests.hasDependencies(quest[1]) then
	    quests.registered_quests["sys4_quests:"..quest[1] ].autoaccept = true
	 end
	 
      end
   end
end

function sys4_quests.intllib_by_item(item)
   local mod = string.split(item, ":")[1]
   if mod == "stairs" then
      for questsMod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, quest in ipairs(registeredQuests.quests) do
	    for __, titem in ipairs(quest[6]) do
	       if item == titem then
		  return registeredQuests.intllib
	       end
	    end
	 end
      end
   end
   return sys4_quests.registeredQuests[mod].intllib
end

function sys4_quests.formatDescription(quest, level, intllib)
   local questType = quest.type
   local targetCount = level
   local customDesc = quest[3]
   
   local str = S(questType).." "..targetCount.." "
   if customDesc ~= nil then
      str = str..intllib(customDesc).."."
   else
      local itemTarget = quest[4][1]
      local item_intllib = sys4_quests.intllib_by_item(itemTarget)
      str = str..item_intllib(itemTarget).."."
   end

   -- Print Unlocked Items
   str = str.."\n \n"..S("The end of the quest unlock this items").." :\n"
   return str..sys4_quests.printUnlockedItems(quest[6])
end

function sys4_quests.printUnlockedItems(items)
   local str = ""
   for _, item in ipairs(items) do
      local itemMod = string.split(item, ":")[1]
      local intllibMod
      if itemMod == "stairs" then
	 for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	    for _, quest in ipairs(registeredQuests.quests) do
	       for __, titem in ipairs(quest[6]) do
		  if item == titem then
		     intllibMod = registeredQuests.intllib
		  end
	       end
	    end
	 end
      else
	 intllibMod = sys4_quests.registeredQuests[itemMod].intllib
      end
      str = str.." - "..intllibMod(item).."\n"
   end

   return str
end

function sys4_quests.updateQuest(questName, targetNodes, items)
   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, quest in ipairs(registeredQuests.quests) do
	 if questName == quest[1] then
	    if targetNodes ~= nil and type(targetNodes) == "table" then
	       for __,targetNode in ipairs(targetNodes) do
		  table.insert(quest[4], targetNode)
	       end
	    end

	    if items ~= nil and type(items) == "table" then
	       for __,item in ipairs(items) do
		  table.insert(quest[6], item)
	       end
	    
	       local questDescription = quests.registered_quests['sys4_quests:'..questName].description
	       questDescription = questDescription..sys4_quests.printUnlockedItems(items)
	       quests.registered_quests['sys4_quests:'..questName].description = questDescription
	    end
	 end
      end
   end
end

function sys4_quests.hasDependencies(questName)
   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, quest in ipairs(registeredQuests.quests) do
	 if quest[7] and quest[7] ~= nil and type(quest[7]) == "string" then
	    local alternQuests = string.split(quest[7], "|")
	    for __, alternQuest in ipairs(alternQuests) do
	       if alternQuest == questName then
		  return true
	       end
	    end
	 elseif type(quest[7]) == "table" then
	    for __, quest_1 in ipairs(quest[7]) do
	       local alternQuests = string.split(quest_1, "|")
	       for ___, alternQuest in ipairs(alternQuests) do
		  if alternQuest == questName then
		     return true
		  end
	       end
	    end
	 end
      end
   end
   return false
end

local function contains(quests, quest)
   local questsList = {}

   if type(quests) == "string" then
      table.insert(questsList, quests)
   else
      questsList = quests
   end

   for _, currentQuest in pairs(questsList) do
      local splittedQuests = string.split(currentQuest, "|")

      for __, splittedQuest in pairs(splittedQuests) do
	 if splittedQuest == quest then
	    return true
	 end
      end
   end

   return false
end

local function isParentQuestsAreSuccessfull(parentQuests, currentQuest, playern)
   local parentQuestsList = {}

   if type(parentQuests) == "string" then
      table.insert(parentQuestsList, parentQuests)
   else
      parentQuestsList = parentQuests
   end

   local isAllFinished = true
   for _, parentQuest in pairs(parentQuestsList) do

      local isFinished = false
      local splittedParentQuests = string.split(parentQuest, "|")

      for __, splittedParentQuest in pairs(splittedParentQuests) do
	 if splittedParentQuest == currentQuest then
	    isFinished = true
	    break
	 else
	    isFinished = isFinished or isQuestSuccessfull(splittedParentQuest, playern)
	 end
      end

      isAllFinished = isAllFinished and isFinished
   end

   return isAllFinished
end

local function getNextQuests(questname, playern)
   local insert = table.insert
   local nextQuests = {}
   
   if questname ~= "" then

      local playerActiveGroup = playerList[playern].activeQuestGroup

      local currentQuest = string.split(questname, ":")[2]

      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do

	    if registeredQuest[1] ~= currentQuest
	       and not isQuestActive(registeredQuest[1], playern)
	       and not isQuestSuccessfull(registeredQuest[1], playern)
	       --and (getGroupByQuestIndex(registeredQuest.index) == nil or
		--       getGroupByQuestIndex(registeredQuest.index) == playerActiveGroup or
		  --  getGroupByQuestIndexWithGlobal(registeredQuest.index) == "global") then
	       then
	       local parentQuests = registeredQuest[7]

	       if parentQuests ~= nil
		  and contains(parentQuests, currentQuest)
	       and isParentQuestsAreSuccessfull(parentQuests, currentQuest, playern) then
		  insert(nextQuests, registeredQuest)
	       end
	    end
	 end
      end
   end

   return nextQuests
end

local function isAllQuestsGroupSuccessfull(currentQuestGroup, questname, playern)
   local successfull = true
   local currentQuest = string.split(questname, ":")[2]

   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, registeredQuest in ipairs(registeredQuests.quests) do
	 if registeredQuest[1] ~= currentQuest
	 and getGroupByQuestIndex(registeredQuest.index) == currentQuestGroup then
	    successfull = successfull and isQuestSuccessfull(registeredQuest[1], playern)
	 end
      end
   end

--   print("Successfull ALL group quest : "..dump(successfull))
   return successfull
end

function sys4_quests.nextQuest(playername, questname)
   --   print("Next quest after : "..questname)
   local nextQuests = getNextQuests(questname, playername)

   local currentQuestGroup = playerList[playername].activeQuestGroup
   local nextQuestGroup = getNextQuestGroup(currentQuestGroup)

--   print("currentQuestGroup : "..currentQuestGroup)
--   print("NEXt QUEST GROUP : "..dump(nextQuestGroup))
   
   if nextQuestGroup ~= nil
   and isAllQuestsGroupSuccessfull(currentQuestGroup, questname, playername) then
      playerList[playername].activeQuestGroup = nextQuestGroup

      -- start quests of the next group
      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do
	    if registeredQuest[7] == nil and getGroupByQuestIndex(registeredQuest.index) == nextQuestGroup then
	       minetest.after(1, function() quests.start_quest(playername, "sys4_quests:"..registeredQuest[1]) end)
	    end
	 end
      end

      if #nextQuests > 0 then
	 for _, nextQuest in pairs(nextQuests) do
	    minetest.after(1, function() quests.start_quest(playername, "sys4_quests:"..nextQuest[1]) end)
	 end
      end
      
   else
      
      for _, nextQuest in pairs(nextQuests) do
	 --      print("Next quest selected : "..nextQuest[1])
	 --nextquest = nextQuest.index
	 --sys4_quests.setCurrentQuest(playername, nextQuest)
	 minetest.after(1, function() quests.start_quest(playername, "sys4_quests:"..nextQuest[1]) end)
      end
   end
end


local function isNodesEquivalent(nodeTargets, nodeDug)
   for _, nodeTarget in pairs(nodeTargets) do
      if nodeTarget == nodeDug then
	 return true
      end
   end

   return false
end

local function getCraftRecipes(item)
   local str = ""
   if item ~= nil and item ~= "" then
      local craftRecipes = minetest.get_all_craft_recipes(item)

      if craftRecipes ~= nil then
	 local first = true
	 for i=1, #craftRecipes do
	    if craftRecipes[i].type == "normal" then
	       if not first then
		  str = str.."\n--- "..S("OR").." ---\n\n"
	       end
	       
	       first = false
	       local width = craftRecipes[i].width
	       local items = craftRecipes[i].items
	       local maxn = table.maxn(items)
	       local h = 0
	       local g
	       if width == 0 then
		  g = 1
		  while g*g < maxn do g = g + 1 end
		  width = maxn
	       else
		  h = math.ceil(maxn / width)
		  g = width < h and h or width
	       end
	       
	       for y=1, g do
		  str = str..y..": "
		  for x=1, width do
		     local itemIngredient = items[(y-1) * width + x]
		     if itemIngredient ~= nil then
			-- local intllib = sys4_quests.intllib_by_item(itemIngredient)
			-- str = str.."'"..intllib(itemIngredient).."' "
			str = str.."["..itemIngredient.."]  "
		     else
			str = str.."[                    ]  "
		     end
		     if x == width then
			str = str.."\n"
		     end
		  end
	       end
	    end
	 end
      else
	       str = S("No craft for this item").."\n"
      end
   end
   return str   
end

local function writeBook(content, items, playern)
   local txt = ""
   
   if content and content ~= nil then
      txt = txt..content.."\n\n"
   end

   if items and items ~= nil then
      txt = txt..playern.." "..S("has unlocked these crafts").." :"

      local tt= "\n\n"
      
      for _, item in ipairs(items) do
	 
	 local intllib = sys4_quests.intllib_by_item(item)
	 
	 tt = tt..">>>> "..intllib(item).." <<<<\n\n"
	 tt = tt..S("Craft recipes").." :\n"
	 tt = tt..getCraftRecipes(item)
	 tt = tt.."\n----------OOOOOO----------\n\n"
      end
      txt = txt..tt.."\n"
   end

   return txt
end

local function getRegisteredQuest(questName)
   if questName and questName ~= nil then
      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do
	    if questName == registeredQuest[1] then
	       return registeredQuest
	    end
	 end
      end
   end

   return nil
end

local function giveBook(playerName, quest)
   if playerName and playerName ~= nil and quest and quest ~= nil then
      local bookItem = ItemStack('default:book_written')
      local registeredQuest = getRegisteredQuest(quest)

      local bookData = {}
      bookData.title = "SYS4 QUESTS : "..registeredQuest[2]
      bookData.text = writeBook(nil, registeredQuest[6], playerName)
      bookData.owner = playerName

      bookItem:set_metadata(minetest.serialize(bookData))

      local receiverRef = core.get_player_by_name(playerName)
      if receiverRef == nil then return end
      receiverRef:get_inventory():add_item("main", bookItem)
   end
end

-- Replace quests.show_message function for customize central_message sounds if the mod is present
local function show_message(t, playername, text)
   if (quests.hud[playername].central_message_enabled) then
      local player = minetest.get_player_by_name(playername)
      cmsg.push_message_player(player, text, quests.colors[t])
      minetest.sound_play("sys4_quests_" .. t, {to_player = playername})
   end
end

if (cmsg) then
   quests.show_message = show_message
end

minetest.register_on_newplayer(
   function(player)
      local playern = player:get_player_name()
      playerList[playern] = {name = playern, isNew = true, craftMode = true, bookMode = false, activeQuestGroup = getFirstQuestGroup()}
--      print("ActiveQuestGroup for New Player : "..playerList[playern].activeQuestGroup)
   end)

minetest.register_on_joinplayer(
   function(player)
      local playern = player:get_player_name()
      if not playerList[playern] or playerList[playern] == nil then
	 playerList[playern] = {name = playern, isNew = false, craftMode = true, bookMode = false, activeQuestGroup = getActiveQuestGroup(playern)}
	 --print("ActiveQuestGroup for Player : "..playerList[playern].activeQuestGroup)
      end

      if (playerList[playern].isNew) then
	 for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	    for _, registeredQuest in ipairs(registeredQuests.quests) do
	       if registeredQuest[7] == nil and (getGroupByQuestIndex(registeredQuest.index) == nil or getGroupByQuestIndex(registeredQuest.index) == playerList[playern].activeQuestGroup) then
		  quests.start_quest(playern, "sys4_quests:"..registeredQuest[1])
	       end
	    end
	 end
      end
   end)

minetest.register_on_dignode(
   function(pos, oldnode, digger)
      local playern = digger:get_player_name()

      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do
	    local questName = registeredQuest[1]
	    local type = registeredQuest.type

	    if type == "dig" and isNodesEquivalent(registeredQuest[4], oldnode.name) then
	       if quests.update_quest(playern, "sys4_quests:"..questName, 1) then
		  minetest.after(1, quests.accept_quest, playern, "sys4_quests:"..questName)
		  if playerList[playern].bookMode then
		     giveBook(playern, questName)
		  end
	       end
	    end
	 end
      end
   end)

minetest.register_on_craft(
   function(itemstack, player, old_craft_grid, craft_inv)
      local playern = player:get_player_name()

      local wasteItem = "sys4_quests:waste"
      local itemstackName = itemstack:get_name()
      local itemstackCount = itemstack:get_count()

      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do
	    local questType = registeredQuest.type
	    local questName = registeredQuest[1]
	    local items = registeredQuest[6]
	    for __, item in ipairs(items) do
	       
	       if item == itemstackName
		  and quests.successfull_quests[playern] ~= nil
		  and quests.successfull_quests[playern]["sys4_quests:"..questName ] ~= nil
	       then
		  wasteItem = nil
	       end
	    end
	 end
      end

--      print("WasteItem state = "..dump(wasteItem))

      for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
	 for _, registeredQuest in ipairs(registeredQuests.quests) do
	    local questType = registeredQuest.type
	    local questName = registeredQuest[1]

	    if questType == "craft" and wasteItem == nil
	    and isNodesEquivalent(registeredQuest[4], itemstackName) then 
	       
	       if quests.update_quest(playern, "sys4_quests:"..questName, itemstackCount) then
		  minetest.after(1, quests.accept_quest, playern, "sys4_quests:"..questName)
		  if playerList[playern].bookMode then
		     giveBook(playern, questName)
		  end
	       end
	       --return nil
	    end
	 end
      end
      
      if wasteItem == nil then
	 return wasteItem
      elseif not playerList[playern].craftMode then
	 return nil
      else
	 return ItemStack(wasteItem)
      end
   end)

local function register_on_placenode(pos, node, placer)
   local playern = placer:get_player_name()

   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, registeredQuest in ipairs(registeredQuests.quests) do
	 local questName = registeredQuest[1]
	 local type = registeredQuest.type
	 
	 if type == "place" and isNodesEquivalent(registeredQuest[4], node.name) then
	    if quests.update_quest(playern, "sys4_quests:"..questName, 1) then
	       minetest.after(1, quests.accept_quest, playern, "sys4_quests:"..questName)
	       if playerList[playern].bookMode then
		  giveBook(playern, questName)
	       end
	    end
	 end
      end
   end
end

minetest.register_on_placenode(register_on_placenode)

local function register_on_place(itemstack, placer, pointed_thing)
   local node = {}
   node.name = itemstack:get_name()
   register_on_placenode(pointed_thing, node, placer)

   -- Meme portion de code que dans la fonction core.rotate_node
   core.rotate_and_place(itemstack, placer, pointed_thing,
			 core.setting_getbool("creative_mode"),
			 {invert_wall = placer:get_player_control().sneak})

   return itemstack
end

local nodes = {
   minetest.registered_nodes["default:tree"],
   minetest.registered_nodes["default:jungletree"],
   minetest.registered_nodes["default:acacia_tree"],
   minetest.registered_nodes["default:pine_tree"],
   minetest.registered_nodes["default:aspen_tree"]
}

for i=1, #nodes do
   nodes[i].on_place = register_on_place
end

minetest.register_chatcommand("lcraft",
{
   params = "[on|off]",
   description = S("Enable or not locked crafts")..".",
   func = function(name, param)
      if param == "on" then
	 playerList[name].craftMode = true
	 minetest.chat_send_player(name, S("Locked crafts Enabled")..".")
      else
	 playerList[name].craftMode = false
	 minetest.chat_send_player(name, S("Locked crafts Disabled")..".")
      end
   end
})

minetest.register_chatcommand("bookmode",
{
   params = "[on|off]",
   description = S("Enable or not books that describe unlocked craft recipes")..".",
   func = function(name, param)
      if param == "on" then
	 playerList[name].bookMode = true
	 minetest.chat_send_player(name, S("Book Mode Enabled")..".")
      else
	 playerList[name].bookMode = false
	 minetest.chat_send_player(name, S("Book Mode Disabled")..".")
      end
   end
})

minetest.register_chatcommand("lqg",
			      {
				 params = "["..S("group index").."]",
				 description = S("Display groups of quests or display quests of a group if group index is given as argument")..".",
				 func = function(name, param)
				    if param ~= "" then
				       local isGroupValid = false
				       for groupName, group in pairs(sys4_quests.questGroups) do
					  if ""..group.order == param then
					     isGroupValid = true
					     minetest.chat_send_player(name, S("Legend")..":")
					     minetest.chat_send_player(name, " [*] <-- "..S("Successfull quest"))
					     minetest.chat_send_player(name, " [!] <-- "..S("Active quest"))
					     minetest.chat_send_player(name, " [ ] <-- "..S("Not reached quest"))
					     minetest.chat_send_player(name, " ")
					     minetest.chat_send_player(name, S("Quests of group").." \""..groupName.."\" : ")
					     for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
						local modIntllib = registeredQuests.intllib
						for _, quest in ipairs(registeredQuests.quests) do
						   local qIndex = quest.index
						   for __, index in ipairs(group.questsIndex) do
						      if index == qIndex then
							 local questState = "[ ]"
							 if isQuestActive(quest[1], name) then
							    questState = "[!]"
							 end
							 if isQuestSuccessfull(quest[1], name) then
							    questState = "[*]"
							 end
							 
							 minetest.chat_send_player(name, questState.." "..modIntllib(quest[2]).." ["..quest[1].."]".." {mod: "..mod.."}")
						      end
						   end
						end
					     end
					  end
				       end

				       if not isGroupValid then
					  minetest.chat_send_player(name, S("Sorry, but this group doesn't exist")..".")
				       end
				    else
				       local groups = {}
				       for groupName, group in pairs(sys4_quests.questGroups) do
					  groups[group.order] = groupName
					  if playerList[name].activeQuestGroup == groupName then
					     groups[group.order] = groupName.." <-- "..S("Active Quests Group")
					  end
				       end
				       
				       for i = 1, #groups do
					  minetest.chat_send_player(name, i.." - "..groups[i])
				       end
				    end
				 end
			      })


minetest.register_chatcommand("itemqq",
			      {
				 params = "<"..S("item")..">",
				 description = S("Display the quest to finish which will unlock this item")..".",
				 func = function(name, param)
				    local isItemFound = false
				    for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
				       local modIntllib = registeredQuests.intllib
				       for _, quest in ipairs(registeredQuests.quests) do
					  for __, uItem in ipairs(quest[6]) do
					     if uItem == param then
						isItemFound = true
						minetest.chat_send_player(name, S("Quest to finish for unlock").." \""..modIntllib(uItem).."\" :")

						local groupName = getGroupByQuestIndex(quest.index)
						if groupName == nil then
						   groupName = "global"
						end

						local questState = ""
						if isQuestActive(quest[1], name) then
						   questState = "<-- "..S("Active")
						end
						if isQuestSuccessfull(quest[1], name) then
						   questState = "<-- "..S("Successfull")
						end
						
						minetest.chat_send_player(name, "  "..modIntllib(quest[2]).." ["..quest[1].."]".." {mod: "..mod.."} "..S("in group").." "..groupName.." "..questState)
						break
					     end
					  end
					  if isItemFound then break end
				       end
				       if isItemFound then break end
				    end
				    if not isItemFound then
				       minetest.chat_send_player(name, S("Sorry, but this item is not unlockable")..".")
				    end
				 end
			      })

minetest.register_chatcommand("fquest",
			      {
				 params = "<"..S("quest_name")..">",
				 description = S("Force an active quest to be immediately finished")..".",
				 func = function(name, param)
				    local quest = getRegisteredQuest(param)
				    local maxValue
				    if quest.custom_level then
				       maxValue = quest[5]
				    else
				       maxValue = quest[5] * level
				    end
				    
				    if quests.update_quest(name, "sys4_quests:"..param, maxValue) then
				       minetest.chat_send_player(name, S("The quest has been finished successfully")..".")
				    else
				       minetest.chat_send_player(name, S("The quest must be active to do that")..".")
				    end
				 end
			      })

local function getModQuest(questName)
   for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
      for _, quest in ipairs(registeredQuests.quests) do
	 if quest[1] == questName then
	    return mod
	 end
      end
   end
   return nil
end

minetest.register_chatcommand("iquest",
			      {
				 params = "<"..S("quest_name")..">",
				 description = S("Display info of the quest")..".",
				 func = function(name, param)
				    local quest = getRegisteredQuest(param)
				    if quest ~= nil then
				       local qMod = getModQuest(quest[1])
				       local modIntllib = sys4_quests.registeredQuests[qMod].intllib
				       local groupName = getGroupByQuestIndex(quest.index)
				       if groupName == nil then
					  groupName = "global"
				       end
				       minetest.chat_send_player(name, "> "..S("Index")..": "..quest.index)
				       minetest.chat_send_player(name, "> "..S("Name")..": "..quest[1])
				       minetest.chat_send_player(name, "> "..S("Title")..": "..modIntllib(quest[2]))
				       local cDesc = quest[3]
				       if cDesc == nil then cDesc = "" end
				       minetest.chat_send_player(name, "> "..S("Custom Desc.")..": "..modIntllib(cDesc))
				       minetest.chat_send_player(name, "> "..S("Group")..": "..groupName)
				       minetest.chat_send_player(name, "> "..S("Mod")..": "..qMod)
				       minetest.chat_send_player(name, "> "..S("Action Type")..": "..S(quest.type))
				       minetest.chat_send_player(name, "> "..S("Target Nodes")..": "..dump(quest[4]))
				       local maxLevel = quest[5] * level
				       if quest.custom_level then
					  maxLevel = quest[5]
				       end
				       minetest.chat_send_player(name, "> "..S("Target count")..": "..maxLevel)
				       minetest.chat_send_player(name, "> "..S("Custom Level")..": "..dump(quest.custom_level))
				       minetest.chat_send_player(name, "> "..S("Parent quests")..": "..dump(quest[7]))
				       
				       local childQuests = {}
				       for mod, registeredQuests in pairs(sys4_quests.registeredQuests) do
					  for _, rQuest in ipairs(registeredQuests.quests) do
					     if rQuest[7] and rQuest[7] ~= nil and type(rQuest[7]) == "string" then
						local alternQuests = string.split(rQuest[7], "|")
						for __, alternQuest in ipairs(alternQuests) do
						   if alternQuest == quest[1] then
						      table.insert(childQuests, rQuest[1])
						   end
						end
					     elseif type(rQuest[7]) == "table" then
						for __, quest_1 in ipairs(rQuest[7]) do
						   local alternQuests = string.split(quest_1, "|")
						   for ___, alternQuest in ipairs(alternQuests) do
						      if alternQuest == quest[1] then
							 table.insert(childQuests, rQuest[1])
						      end
						   end
						end
					     end
					  end
				       end
				       minetest.chat_send_player(name, "> "..S("Child Quests")..": "..dump(childQuests))
				       
				       minetest.chat_send_player(name, "> "..S("Items to unlock")..": "..dump(quest[6]))
				       local questState = "Inactive"
				       if isQuestActive(quest[1], name) then
					  questState = "Active"
				       end
				       if isQuestSuccessfull(quest[1], name) then
					  questState = "Successfull"
				       end
				       minetest.chat_send_player(name, "> "..S("State")..": "..S(questState))
				    else
				       minetest.chat_send_player(name, S("Sorry, but this quest doesn't exist")..".")
				    end
				 end
			      })

minetest.register_chatcommand("getcraft",
			      {
				 params = "<"..S("item")..">",
				 description = S("Display craft recipes of this item")..".",
				 func = function(name, param)
				    minetest.chat_send_player(name, getCraftRecipes(param))
				 end

			      })
