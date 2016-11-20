-- for covering old version item

minetest.register_alias("group:sand", "marssurvive:sand")
minetest.register_alias("group:sapling", "marssurvive:mars_sapling")
minetest.register_alias("group:stone", "marssurvive:stone")
minetest.register_alias("group:cobble", "marssurvive:cobble")
minetest.register_alias("group:wood", "marssurvive:wood")

minetest.register_on_newplayer(function(player)
    player:setpos({x=52.2, y=12.5, z=-197.1})
    return true
end)

minetest.register_on_respawnplayer(function(player)
--    player:setpos({x=46.9, y=12.5, z=-197})

--[[
    local inv=player:get_inventory()

    -- empty lists main and craft
    inv:set_list("main", {})
    inv:set_list("craft", {})

  	inv:add_item("main","marssurvive:sp")
  	inv:add_item("main","marssurvive:sandpick")
  	inv:add_item("main","marssurvive:air_gassbotte")
  	inv:add_item("main","default:lamp_wall")
  	inv:add_item("main","default:apple 5")
    inv:add_item("main","farming:bread 2")
--]]

    return true

end)

minetest.register_on_joinplayer(function(player)

--	minetest.chat_send_all("ready to revoke privs")
  local playername = player:get_player_name()
--  minetest.chat_send_all(playername)
  if ((playername ~= "tm3") and (playername ~= "juli") and (playername ~= "yang2003") and (playername ~= "admin")) then
    local privs = minetest.get_player_privs(playername)
--    minetest.chat_send_all("ready to revoke privs")

    if (privs.interact) then
--    minetest.chat_send_all("for interat")
    minetest.set_player_privs(playername,{})
--    minetest.chat_send_all(dump(minetest.get_player_privs(playername)))
    local privs = minetest.get_player_privs(playername)
    privs.home = true
    privs.shout = true
    privs.interact = true
    minetest.set_player_privs(playername, privs)
    else
--      minetest.chat_send_all("for no interat")
      minetest.set_player_privs(playername,{})
--      minetest.chat_send_all(dump(minetest.get_player_privs(playername)))
      local privs = minetest.get_player_privs(playername)
      privs.home = true
      privs.shout = true
      minetest.set_player_privs(playername, privs)
    end
--    minetest.chat_send_all("revoke completely")
--    minetest.chat_send_all(dump(minetest.get_player_privs(playername)))
  end

end)


minetest.register_chatcommand("getip", {
    params = "<name>",
    description = "Get IP of player",
    privs = {privs = true},
    func = function(name, param)
        if minetest.get_player_by_name(param) == nil then
            minetest.chat_send_player(name, "Player not found")
            return
        end
        minetest.chat_send_player(name, "IP of " .. param .. " is ".. minetest.get_player_ip(param))
    end,
})


minetest.register_abm({
	nodenames = {"marssurvive:cobble"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

--[[
minetest.register_abm({
	nodenames = {"bones:bones_infected"},
	neighbors = {"air"},
	interval = 60,
	chance = 5,
	catch_up = false,
	action = function(pos, node)
  pos.y = pos.y+2
--  minetest.chat_send_all(minetest.get_node_light(pos,nil))
  if (minetest.get_node_light(pos,nil)) < 4 then
      minetest.add_entity(pos,"zombies:zombie")
  end

	end
})
--]]


minetest.register_abm({
	nodenames = {"marssurvive:stone"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

--water will be dry
minetest.register_abm({
	nodenames = {"default:water_source","default:water_flowing"},
	neighbors = {"marssurvive:sand"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
	end
})




-- fuels additional

minetest.register_craft({
	type = "fuel",
	recipe = "marssurvive:mars_sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marssurvive:wood",
	burntime = 15,
})

--others
minetest.register_craft({
	output = 'default:lamp_wall 2',
	recipe = {
		{'default:glass', '', ''},
		{'default:torch', '', ''},
		{'default:glass', '', ''},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:water_source",
	recipe = "marssurvive:ice",
})

minetest.register_craft({
	type = "cooking",
	output = "default:water_source",
	recipe = "caverealms:thin_ice",
})

minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:cobble', 'group:cobble', 'group:cobble'},
		{'group:cobble', '', 'group:cobble'},
		{'group:cobble', 'group:cobble', 'group:cobble'},
	}
})

minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'', 'default:apple', ''},
		{'', 'default:dirt', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'marssurvive:sand 3',
	recipe = {
		{'default:sandstone'},
	}
})

minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'marssurvive:sand'},
	}
})

minetest.register_craft({
	output = 'default:sandstone',
	recipe = {
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
	}
})

minetest.register_craft({
  type = "cooking",
	output = 'default:desert_stone',
	recipe = 'marssurvive:stone',
})

minetest.register_craft({
  type = "cooking",
	output = 'default:desert_cobble',
	recipe = 'marssurvive:cobble',

})

minetest.register_craft({
  type = "cooking",
	output = 'default:clay_lump 2',
	recipe = 'marssurvive:clayblock',
})

-- for technic ore

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_uranium",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_chromium",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_zinc",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_lead",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:granite",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:marble",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})
