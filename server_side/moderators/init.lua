

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

--extra command

minetest.register_chatcommand("bring", {

	params = "Usage:bring <name>",
	description = "bring moderator immediately to a player's location",
	privs = {basic_privs = true},

	func = function(name, param)

--    minetest.chat_send_player(name, name.." "..param)

    local player = minetest.get_player_by_name(param)
    if player == nil then
       minetest.chat_send_player(name,"player "..param.."is not avilable or off-line")
       return false
    end

    local caller = minetest.get_player_by_name(name)
    local pos = player:getpos()

--    minetest.chat_send_player(name, "X "..pos.x)
--    minetest.chat_send_player(name, "Y "..pos.y)
--    minetest.chat_send_player(name, "Z "..pos.z)

    caller:setpos({x=pos.x,y=pos.y,z=pos.z})
      minetest.chat_send_player(name, "Teleported to player "..param.."!")

	end
})

minetest.register_chatcommand("getip", {
    params = "Usage:getip <name>",
    description = "Get IP of player",
    privs = {basic_privs = true},
    func = function(name, param)
        if minetest.get_player_by_name(param) == nil then
            minetest.chat_send_player(name, "Player not found")
            return
        end
        minetest.chat_send_player(name, "IP of " .. param .. " is ".. minetest.get_player_ip(param))
    end,
})

minetest.register_chatcommand("spawn", {

	params = "",
	description = "spawn to player hall",
	privs = {},

	func = function(name, param)
--    minetest.chat_send_player(name, name.." "..param)
    local caller = minetest.get_player_by_name(name)
    caller:setpos({x=46.9, y=12.5, z=-197})
    minetest.chat_send_player(name, "Spawn to player hall")
	   end
})

--[[
minetest.register_chatcommand("grant", {
	params = "",
	description = "override grant",
	privs = {privs = true},

	func = function(name, param)
--            local param1 = ""
--    minetest.chat_send_player(name,param)
            local sep = "%s"
            local t={} ; i=1
            for str in string.gmatch(param, "([^"..sep.."]+)") do
                    t[i] = str
                    --minetest.chat_send_player(name,i..t[i])
                    i = i + 1
            end
            local set_privs = t[2]
            local set_name = t[1]
            local privs = minetest.get_player_privs(set_name)
--            minetest.chat_send_all(dump(privs))

            if set_privs == "interact" then
            privs.interact = true
            elseif (set_privs == "give" and name == "admin") then
            privs.give = true
            elseif (set_privs == "teleport" and name == "admin") then
            privs.teleport = true
            elseif (set_privs == "bring" and name == "admin") then
            privs.bring = true
            elseif set_privs == "fast" then
            privs.fast = true
            elseif (set_privs == "fly" and name == "admin") then
            privs.fly = true
            elseif (set_privs == "noclip" and name == "admin") then
            privs.noclip = true
            elseif set_privs == "shout" then
            privs.shout = true
            elseif (set_privs == "settime" and name == "admin") then
            privs.settime = true
            elseif (set_privs == "privs" and name == "admin") then
            privs.privs = true
            elseif set_privs == "basic_privs" then
            privs.basic_privs = true
            elseif set_privs == "kick" then
            privs.kick = true
            elseif set_privs == "ban" then
            privs.ban = true
            elseif set_privs == "rollback" then
            privs.rollback = true
            elseif set_privs == "areas" then
            privs.areas = true
            end
--            minetest.chat_send_all(dump(privs))

            minetest.set_player_privs(set_name, privs)

    --
	end
})
--]]
