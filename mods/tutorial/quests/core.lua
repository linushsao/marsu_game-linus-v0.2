-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	-- If you don't use insertions (@1, @2, etc) you can use this:
	S = function(s) return s end
end

-- starts all quests which follow this quest
function quests.start_next_quests(playername, questname)
	local quest = quests.registered_quests[questname]
	if type(quest.next) ~= "table" then 
		if quest.next ~= nil then 
			--minetest.chat_send_all("finished "..questname)
			--minetest.chat_send_all("group "..dump(quest.group).." finished? ")
			if quest.group == nil
			   or quests.all_quests_group_finished(playername, 
							quest.group) 
			then
				--minetest.chat_send_all("true")
				quests.start_all_group_quests(playername, 
							quest.next)
			--else	
			--	minetest.chat_send_all("false")
			end
		end
	else
		for _, nextquest in pairs(quest.next) do
			quests.start_quest(playername, nextquest)
		end
	end
end

-- registers a quest for later use
--
-- questname is the name of the quest to identify it later
-- 	it should follow the naming conventions: "modname:questname"
-- quest is a table in the following format
-- 	{
--	  title, 		-- is shown to the player and should contain usefull information about the quest.
--	  description, 		-- a small description of the mod.
-- 	  max,			-- is the desired maximum. If max is 1, no maximum is displayed. defaults to 1
-- 	  autoaccept, 		-- is true or false, wether the result of the quest should be dealt by this mode or the registering mod.
-- 	  callback 		-- when autoaccept is true, at the end of the quest, it gets removed and callback is called.
--	                        -- function(playername, questname, metadata)
--	}
--
-- returns true, when the quest was successfully registered
-- returns falls, when there was already such a quest
function quests.register_quest(name, quest)
	if (quests.registered_quests[name] ~= nil) then
		minetest.log("warning", "quest "..name.."already registered")
		return false -- The quest was not registered since there already a quest with that name
	end

	quest.autoaccept = 1
	if quest.item_name ~= nil then
		if quests.item_map[quest.item_name] == nil then
			quests.item_map[quest.item_name] = {}
		end
		table.insert(quests.item_map[quest.item_name], name)
	end
	if quest.autostart then
		table.insert(quests.autostart, name)
	end
	quests.registered_quests[name] =
		{ title       = quest.title or S("missing title"),
		  description = quest.description or S("missing description"),
		  max         = quest.max or 1,
		  autoaccept  = quest.autoaccept or false,
		  callback    = quest.callback,
		  on_start    = quest.on_start,
		  next        = quest.next,
		  type        = quest.type,
		  item_name   = quest.item_name,
		  group       = quest.group,
		  image       = quest.image,
	  	}
	return true	
end

-- starts a quest for a specified player
--
-- playername - the name of the player
-- questname  - the name of the quest, which was registered with quests.register_quest
-- metadata   - optional additional data
--
-- returns false on failure
-- returns true if the quest was started
function quests.start_quest(playername, questname, metadata)
	if (quests.registered_quests[questname] == nil) then
		return false
	end
	if (quests.active_quests[playername] == nil) then
		quests.active_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] ~= nil) then
		return false -- the player has already this quest
	end
	quests.active_quests[playername][questname] = {value = 0, metadata = metadata}

	quests.update_hud(playername)
	quests.show_message("new", playername, S("New quest:") .. " " .. quests.registered_quests[questname].title)
	local on_start = quests.registered_quests[questname].on_start
	if on_start ~= nil then
		on_start(playername, questname, metadata)
	end
	return true
end

-- when something happens that has effect on a quest, a mod should call this method
-- playername is the name of the player
-- questname is the quest which gets updated
-- the quest gets updated by value
-- this method calls a previously specified callback if autoaccept is true
--
-- returns true if the quest is finished
-- returns false if there is no such quest or the quest continues
function quests.update_quest(playername, questname, value)
	if (quests.active_quests[playername] == nil) then
		quests.active_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] == nil) then
		return false -- there is no such quest
	end
	if (quests.active_quests[playername][questname].finished) then
		return false -- the quest is already finished
	end
	if (value == nil) then
		return false -- no value given
	end
	quests.active_quests[playername][questname]["value"] = quests.active_quests[playername][questname]["value"] + value
	if (quests.active_quests[playername][questname]["value"] >= quests.registered_quests[questname]["max"]) then
		quests.active_quests[playername][questname]["value"] = quests.registered_quests[questname]["max"]
		if (quests.registered_quests[questname]["autoaccept"]) then
			if (quests.registered_quests[questname]["callback"] ~= nil) then
				quests.registered_quests[questname]["callback"](playername, questname,
					quests.active_quests[playername][questname].metadata)	
			end
			quests.accept_quest(playername,questname)
			quests.start_next_quests(playername, questname)
			quests.update_hud(playername)
		end
		return true -- the quest is finished
	end
	quests.update_hud(playername)
	return false -- the quest continues
end

-- When the mod handels the end of quests himself, e.g. you have to talk to somebody to finish the quest,
-- you have to call this method to end a quest
-- returns true, when the quest is completed
-- returns false, when the quest is still ongoing
function quests.accept_quest(playername, questname)
	if (quests.active_quests[playername][questname] and not quests.active_quests[playername][questname].finished) then
		if (quests.successfull_quests[playername] == nil) then
			quests.successfull_quests[playername] = {}
		end
		if (quests.successfull_quests[playername][questname] ~= nil) then
			quests.successfull_quests[playername][questname].count = quests.successfull_quests[playername][questname].count + 1
		else
			quests.successfull_quests[playername][questname] = {count = 1}
		end
		quests.active_quests[playername][questname].finished = true
		for _,quest in ipairs(quests.hud[playername].list) do
			if (quest.name == questname) then
				local player = minetest.get_player_by_name(playername)
				player:hud_change(quest.id, "number", quests.colors.success)
			end
		end
		quests.show_message("success", playername, S("Quest completed:") .. " " .. quests.registered_quests[questname].title)
		minetest.after(3, function(playername, questname)
			quests.active_quests[playername][questname] = nil
			quests.update_hud(playername)
		end, playername, questname)
		return true -- the quest is finished, the mod can give a reward
	end
	return false -- the quest hasn't finished
end

-- call this method, when you want to end a quest even when it was not finished
-- example: the player failed
--
-- returns false if the quest was not aborted
-- returns true when the quest was aborted
function quests.abort_quest(playername, questname)
	if (questname == nil) then
		return false
	end	
	if (quests.failed_quests[playername] == nil) then
		quests.failed_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] == nil) then
		return false
	end
	if (quests.failed_quests[playername][questname] ~= nil) then
		quests.failed_quests[playername][questname].count = quests.failed_quests[playername][questname].count + 1
	else
		quests.failed_quests[playername][questname] = { count = 1 }
	end

	quests.active_quests[playername][questname].finished = true
	for _,quest in ipairs(quests.hud[playername].list) do
		if (quest.name == questname) then
			local player = minetest.get_player_by_name(playername)
			player:hud_change(quest.id, "number", quests.colors.failed)
		end
	end
	quests.show_message("failed", playername, S("Quest failed:") .. " " .. quests.registered_quests[questname].title)
	minetest.after(3, function(playername, questname)
		quests.active_quests[playername][questname] = nil
		quests.update_hud(playername)
	end, playername, questname)
end

-- get metadata of the quest if the quest exists, else return nil
function quests.get_metadata(playername, questname)
	if (quests.active_quests[playername] == nil or quests.active_quests[playername][questname] == nil) then
		return nil
	end
	return quests.active_quests[playername][questname].metadata
end

-- set metadata of the quest
function quests.set_metadata(playername, questname, metadata)
	if (quests.active_quests[playername] == nil or quests.active_quests[playername][questname] == nil) then
		return
	end
	quests.active_quests[playername][questname].metadata = metadata
end

-- handling of quests
function quests.all_quests_group_finished(playername, groupname)
	for name, quest in pairs(quests.registered_quests) do
	    if quest.group == groupname then
		--print(dump(quests.successfull_quests))
		--print(dump(quests.successfull_quests[playername]))
		--print(dump(quests.successfull_quests[playername][name]))

		local status = quests.successfull_quests[playername][name]
		--minetest.chat_send_all("test quest "..name)
		--minetest.chat_send_all(dump(status)..dump(status == nil)..dump(status and status.count))
		if status == nil or not status.count then 
			--minetest.chat_send_all(name.. " of group "..groupname.." not finished!")
			return false 
		end
	    end
	end
	return true
end

function quests.start_all_group_quests(playername, groupname)
	for questname, quest in pairs(quests.registered_quests) do
		if quest.group == groupname then
			quests.start_quest(playername, questname)
		end
	end
end

function quests.check_player_finished_all(playername)
	if not quests.active_quests[playername] then return false end
	return (next(quests.active_quests[playername]) == nil)
end

-- continues a quest by diggin, placing, crafting
-- itemstack_node is itemstack if type_ = "craft"
-- and node for type_ = "place" or type_ = "dig"
function quests.do_quest(itemname, itemcount, player, type_)
	if player == nil then 
		minetest.log("error", "player == nil at quests.do_quest")
		return 
	end
	minetest.log("action", "do quest: "..type_..":"..itemname)
	local playername = player:get_player_name()
	if quests.check_player_finished_all(playername) then return end
	
	local item_quests = quests.item_map[itemname]
	-- does there exists a quest for this item?
	if item_quests == nil then return end
	
	
	for _, name in pairs(item_quests) do
		minetest.log("action", playername.. " does quest " .. name)
		local quest = quests.registered_quests[name]
		if quest == nil then 
			log("error", "quest for item defined but not"..
				     "registered (name = "..name..")")
			return
		end
		-- handle only craft quests here
		if quest.type == type_ then
			quests.update_quest(playername, name, itemcount)
		end
	end
end

minetest.register_on_craft(function(itemstack, player, grid, craft_inv)
	quests.do_quest(itemstack:get_name(), itemstack:get_count(), 
	player, "craft")
end)
minetest.register_on_placenode(function(pos, newnode, placer)
	quests.do_quest(newnode.name, 1, placer, "place")
end)
minetest.register_on_dignode(function(pos, oldnode, digger)
	quests.do_quest(oldnode.name, 1, digger, "dig")
end)

minetest.register_on_newplayer(function(player) 
	minetest.after(5, function()
		local name = player:get_player_name()
		for _, questname in pairs(quests.autostart) do
			minetest.log("debug", name.." starts "..questname.."!")
			quests.start_quest(name, questname)
		end
	end)
end)

-- example:
--quests.register_quest("craft_wood_pick", {
--	title = "craft a wooden pickaxe",
--	description = "test",
--	max = 2, -- craft 2 pickaxes
--	callback = function() print("quest finished!") end,
--	next = {"dig_sand"},
--	autostart = true,
--	item_name = "default:pick_wood",
--	type = "craft"
--})
--quests.register_quest("dig_sand", {
--	title = "dig sand",
--	description = "test",
--	max = 2, -- dig 2 sand
--	callback = function() print("quest finished!") end,
--	next = {"craft_wood_pick", "place_dirt"},
--	autostart = true,
--	item_name = "default:sand",
--	type = "dig"
--})
--quests.register_quest("place_dirt", {
--	title = "place dirt",
--	description = "test",
--	max = 2, -- craft 2 pickaxes
--	callback = function() print("quest finished!") end,
--	next = {},
--	autostart = true,
--	item_name = "default:dirt",
--	type = "place"
--})




