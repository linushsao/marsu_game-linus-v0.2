

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

--spawn point
minetest.register_on_newplayer(function(player)
    player:setpos({x=52.2, y=12.5, z=-197.1})
    return true
end)

--check privs for areas for all players
minetest.register_on_joinplayer(function(player)

--	minetest.chat_send_all("ready to revoke privs")
  local playername = player:get_player_name()
--  minetest.chat_send_all(playername)
 -- if ((playername ~= "tm3") and (playername ~= "juli") and (playername ~= "yang2003") and (playername ~= "admin")) then
  if ( (not is_md0(playername)) and (not is_md0(playername)) and (not is_md0(playername)) and (not is_md0(playername)))  then
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

--from juli
--[[
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    if minetest.is_protected(pos, puncher) then
            print("jail...")
       puncher:setpos({x=-408, y=-4180, z=-97})
    end
end)
--]]

--from Gundul
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
   if not areas:canInteract(pos, name) then
      return true
   end
   return old_is_protected(pos, name)
end

minetest.register_on_protection_violation(function(pos, name)

   if not areas:canInteract(pos, name) then
      local owners = areas:getNodeOwners(pos)
      minetest.chat_send_player(name,
         ("%s is protected by %s."):format(
            minetest.pos_to_string(pos),
            table.concat(owners, ", ")))

      -- Begin here teleporting player to x,y,z if touching
       local player = minetest.get_player_by_name(name) -- local var for playername

        if not player then return end

         player:setpos({x=-408, y=-4180, z=-97}) --- teleport to Coordinate x,y,z

   end
end)

--warning before reboot
local timer = 0
local check_time = ""

minetest.register_globalstep(function(dtime)

	timer = timer + dtime

	if timer >= 60 then
    check_time = os.date("%H:%M")
    if check_time=="23:54" then
          minetest.chat_send_all("!!!Warning,Server will be restarted after 5 mins!!!")
    end
    if check_time=="23:58" then
          minetest.chat_send_all("!!!Warning,Server will be restarted after 1 mins!!!")
          minetest.chat_send_all("!!!Server will be online again in a minute !!!")
    end
		timer = 0
	end
end)
