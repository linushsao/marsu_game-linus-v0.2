

minetest.log("action","MOD: moderators loading ...")

--regist new privilege
minetest.register_privilege("supervisor", {
	description = "Highest Level Managers of Server",
	give_to_singleplayer = false
})


--loading extra lua
dofile(minetest.get_modpath("moderators") .. "/config.lua")
dofile(minetest.get_modpath("moderators") .. "/function.lua")
dofile(minetest.get_modpath("moderators") .. "/command.lua")
dofile(minetest.get_modpath("moderators") .. "/record_griefer.lua")
dofile(minetest.get_modpath("moderators") .. "/crafting.lua")

--spawn point
minetest.register_on_newplayer(function(player)
    player:setpos({x=62, y=13, z=-197})
    return true
end)

--respawn to player hall when die
minetest.register_on_respawnplayer(function(player)

		player:setpos({x=66, y=6.5, z=-198})
		return true

end)

--check privs for areas for all players
minetest.register_on_joinplayer(function(player)

print("CHECK PLAYERS")
--	minetest.chat_send_all("ready to revoke privs")
  local playername = player:get_player_name()
--  minetest.chat_send_all(playername)
 -- if ((playername ~= "tm3") and (playername ~= "juli") and (playername ~= "yang2003") and (playername ~= "admin")) then
  if is_md0(playername) then
--		recovery_md0_privs()
		return true
	else
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





--warning before reboot
local timer = 0
local check_time = ""

minetest.register_globalstep(function(dtime)

	local check_file_reset = minetest.get_worldpath() .. "/check_file_reset"


	timer = timer + dtime

	if timer >= 60 then

		check_time = (os.date("%H%M"))

    if check_time == "2354" then
          minetest.chat_send_all("!!!Warning,Server will be restarted after 5 mins!!!")
    elseif check_time == "2358" then
          minetest.chat_send_all("!!!Warning,Server will be restarted after 1 mins!!!")
          minetest.chat_send_all("!!!Server will be online again in a minute !!!")
					recovery_md0_privs() --recovery supervisors's privs
					--[[
					if io.open(check_file_reset, "r") ~= nil then
						local check_file = minetest.get_worldpath() .. "/check_file" --means reset privs for supervisors
						local check_file_worldedit = minetest.get_worldpath() .. "/check_file_worldedit" --means add worldedit privs for supervisors

						os.execute("rm -rf "..check_file_worldedit)
						os.execute("touch  "..check_file)
					end
					]]

    end
		timer = 0
	end

end)

minetest.register_on_shutdown(function()
--recovery_md0_privs() --recovery supervisors's privs
end)
