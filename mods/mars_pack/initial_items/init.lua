-- adding spacesuit to new players
minetest.register_on_newplayer(function(player)
	local inv=player:get_inventory()
	inv:add_item("main","spacesuit:sp")
	inv:add_item("main","marssurvive:sandpick")
	inv:add_item("main","spacesuit:air_gassbottle")
	if minetest.check_player_privs(player:get_player_name(), {server=true}) then
		inv:add_item("main","marssurvive:tospaceteleporter")
	end
	
	--enforce spacesuit stack one:
	local stack_one = inv:get_stack("main", 1)
	if stack_one.name ~= "spacesuit:sp" then
		inv:set_stack("main", 1, {name="spacesuit:sp", count=1, wear=0, metadata=""})
		inv:add_item(stack_one)
	end
end)
print("[MOD] mars-pack_initial_items loaded!")
