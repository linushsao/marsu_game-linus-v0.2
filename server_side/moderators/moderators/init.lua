

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



local not_reset_privs = {
	interact=1, full_air_spread=1, home=1, shout=1
}
--check privs for areas for all players
minetest.register_on_joinplayer(function(player)

  local playername = player:get_player_name()
  
    if is_md0(playername) then
	--	recovery_md0_privs()
		return true
    else
	local privs = minetest.get_player_privs(playername)
	minetest.set_player_privs(playername,{})
	for priv, value in pairs(privs) do
	    if not not_reset_privs[priv] then
		    privs[priv] = nil
	    end
	end
	minetest.set_player_privs(playername, privs)
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

--read all configure at server starting
msg = {}
worldedit_limits = {}

local function loadmsg()

	local msg_file = minetest.get_worldpath() .. "/messages"
	local input = io.open(msg_file, "r")
    if input == nil then return
    else
     msg = minetest.deserialize(input:read("*all"))
     print(dump(msg))
     io.close(input)
    end

end

local function load_worldedit_limits()

	local worldedit_limits_file = minetest.get_worldpath() .. "/worldedit_limits"
	local input = io.open(worldedit_limits_file, "r")
    if input == nil then return
    else
     worldedit_limits = minetest.deserialize(input:read("*all"))
     print(dump(worldedit_limits))
     io.close(input)
    end

end

local function load_mars_conf()

	local mars_conf_file = minetest.get_worldpath() .. "/mars_conf"
	local input = io.open(mars_conf_file, "r")
	local positions = {"spawn","respawn","jail"}

    	if input == nil then
				mars_conf["spawn"]={x=spawn_point.x,y=spawn_point.y,z=spawn_point.z}
				mars_conf["respawn"]={x=respawn_point.x,y=respawn_point.y,z=respawn_point.z}
				mars_conf["jail"]={x=jail_point.x,y=jail_point.y,z=jail_point.z}
				mars_conf["md_0"]=md_0
				return
			end

			mars_conf = minetest.deserialize(input:read("*all"))
			io.close(input)
			--setup the config
				if mars_conf["spawn"] == nil then
					mars_conf["spawn"]={x=spawn_point.x,y=spawn_point.y,z=spawn_point.z}
					elseif mars_conf["respawn"] == nil then
						mars_conf["respawn"]={x=respawn_point.x,y=respawn_point.y,z=respawn_point.z}
					elseif mars_conf["jail"] == nil then
						mars_conf["jail"]={x=jail_point.x,y=jail_point.y,z=jail_point.z}
					elseif mars_conf["md_0"] == nil then
						mars_conf["md_0"]=md_0
				end
end

function register_pos_conf()

	if mars_conf == nil then return end
	--spawn point
	minetest.register_on_newplayer(function(player)
		player:setpos({x=mars_conf["spawn"].x, y=mars_conf["spawn"].y, z=mars_conf["spawn"].z})
		return true
	end)

	--respawn to player hall when die
	minetest.register_on_respawnplayer(function(player)
		player:setpos({x=mars_conf["respawn"].x, y=mars_conf["respawn"].y, z=mars_conf["respawn"].z})
		return true
	end)

	--jail the same as interact.lua of area mod
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
				 player:setpos({x=mars_conf["jail"].x, y=mars_conf["jail"].y, z=mars_conf["jail"].z}) --- teleport to Coordinate x,y,z
		end
	end)

end

loadmsg()
load_worldedit_limits()
load_mars_conf()
register_pos_conf()

minetest.register_on_shutdown(function()
	save_all_mars_config()
	minetest.log("action","mars_config saved.")

end)

minetest.log("action","MOD: moderators loaded.")
