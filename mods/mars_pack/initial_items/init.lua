-- adding spacesuit to new players
minetest.register_on_newplayer(function(player)
	local inv=player:get_inventory()
	inv:add_item("main","spacesuit:sp")
	inv:add_item("main","marssurvive:sandpick")
	inv:add_item("main","spacesuit:air_gassbottle")
	if minetest.check_player_privs(player:get_player_name(), {server=true}) then
		inv:add_item("main","marssurvive:tospaceteleporter")
	end
end)
print("[MOD] mars-pack_initial_items loaded!")