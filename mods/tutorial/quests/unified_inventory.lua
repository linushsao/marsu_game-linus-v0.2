quests.unif_inv_send_form = {}
unified_inventory.register_button("quests", {
	type = "image",
	image = "inventory_plus_quests.png",
	tooltip = "Show the questlog",
--	action = function(player)
--		quests.show_formspec(player:get_player_name())
--	end
})

unified_inventory.register_page("quests", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "1", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_successfull", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "2", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_failed", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "3", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_config", {
	get_formspec = function(player)
		local playername = player:get_player_name()
		local formspec = quests.create_config(playername, true)
		return {formspec = formspec, draw_inventory = false }
	end
})
unified_inventory.register_page("quests_info", {
	get_formspec = function(player)
		local playername = player:get_player_name()
		local formspec = quests.create_info(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id], true)
		return {formspec = formspec, draw_inventory = false }
	end
})

quests.open_unified_inventory_craftguide = function(playername, item,alternate) 
	quests.unif_inv_send_form[playername] = true
	local player = minetest.get_player_by_name(playername)
	unified_inventory.current_item[playername] = item
	if not alternate then alternate = 1 end
	unified_inventory.current_craft_direction[playername] = "recipe"
	unified_inventory.alternate[playername] = alternate
	unified_inventory.set_inventory_formspec(player, "craftguide")
	local formspec = player:get_inventory_formspec()
	minetest.show_formspec(playername, "", formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	--local playername = player:get_player_name()
	--minetest.chat_send_all(dump(fields))
	if fields.quit ~= nil then
	--	quests.unif_inv_send_form[playername] = false
		return
	end
	if formname == "" then
		--if not quests.unif_inv_send_form[playername] then return end
		minetest.after(0, function(player)
			local name = player:get_player_name()
			local form = player:get_inventory_formspec()
			minetest.show_formspec(name, "", form)
		end, player)
	end
end)
