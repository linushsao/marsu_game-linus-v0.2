

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

	params = "Usage:bring player to spawn(player hall)",
	description = "spawn to player hall",
	privs = {},

	func = function(name, param)
    local caller = minetest.get_player_by_name(name)
    caller:setpos({x=66, y=6.5, z=-198})
    minetest.chat_send_player(name, "Spawn to player hall")
	   end
})

minetest.register_chatcommand("grant-md", {
    params = "Usage:grant-md <name>",
    description = "grant player privs of moderator,used for supervisor",
    privs = {supervisor = true},

    func = function(name,param)
			print("name:"..name..",param:"..param)
        if (not is_md0(param)) then

            local privs = minetest.get_player_privs(param)
            minetest.set_player_privs(param,{})
            local privs = minetest.get_player_privs(param)
            privs.home = true
            privs.shout = true
            privs.basic_privs = true
            privs.protection_bypass = true
            privs.rollback = true
            privs.kick = true
            privs.interact = true

            minetest.set_player_privs(param, privs)

    				minetest.chat_send_all(name.." grant "..param.." to be an moderator!!!")

					else

						minetest.chat_send_player(name,param.." is already a supervisor!!!")

        end

  end

})


minetest.register_chatcommand("revoke-md", {
    params = "Usage:grant-md <name>",
    description = "revoke player privs from moderator to normal player,used for supervisor",
    privs = {supervisor = true},

		func = function(name,param)

        if (not is_md0(param)) then
					local privs = minetest.get_player_privs(param)
          minetest.set_player_privs(param,{})
            local privs = minetest.get_player_privs(param)
            privs.home = true
            privs.shout = true
            privs.interact = true

            minetest.set_player_privs(param, privs)

						minetest.chat_send_player(name," revoke "..param.." an normal player.")
			else

				minetest.chat_send_player(name,"revoke ignore,"..param.." is also a supervisor!!!")

			end


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
