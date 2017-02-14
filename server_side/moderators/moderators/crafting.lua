--API collection

minetest.register_tool("moderators:worldedit_tool", {
    description = "Big APPLE",
    inventory_image = "moderators_worldedit_tool.png",

    on_use = function(itemstack, user, pointed_thing)

      local playername = user:get_player_name()
	  local count = 1
			for _, player in pairs(worldedit_limits) do
				if player == playername then count = count + 1 end
			end
			print("count:"..count)
	  if count > 30 then
	        minetest.chat_send_player(playername, "Worldedit only could be used twice per month")
      elseif is_md0(playername) then
  		    print("playername:"..playername)
  		    local privs = minetest.get_player_privs(playername)
  		    privs.worldedit = true
  		    minetest.set_player_privs(playername, privs)

  		    --add playername in array
			table.insert(worldedit_limits,1,playername)
	        local worldedit_limits_file = minetest.get_worldpath() .. "/worldedit_limits"
			print(dump(worldedit_limits))
			local output = io.open(worldedit_limits_file, "w")
            output:write(minetest.serialize(worldedit_limits).."\n")
            io.close(output)

            minetest.chat_send_player(playername, "Server have grant privs *worldedit* to "..playername)
  		    -- Takes one item from the stack
  		    itemstack:take_item()
  		    return itemstack
       else
          minetest.chat_send_player(playername, "access denied,only supervisors could use this tools")
      end

  	end

})
