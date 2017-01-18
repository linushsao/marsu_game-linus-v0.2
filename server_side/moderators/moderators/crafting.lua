--API collection

minetest.register_tool("moderators:worldedit_tool", {
    description = "Big APPLE",
    inventory_image = "moderators_worldedit_tool.png",

    on_use = function(itemstack, user, pointed_thing)

      local playername = user:get_player_name()

      if is_md0(playername) then
  		    print("playername:"..playername)
  		    local privs = minetest.get_player_privs(playername)
  		    privs.worldedit = true
  		    minetest.set_player_privs(playername, privs)

          minetest.chat_send_player(playername, "Server have grant privs *worldedit* to "..playername)
  		    -- Takes one item from the stack
  		    itemstack:take_item()
  		    return itemstack
        else
          minetest.chat_send_player(playername, "access denied,only supervisors could use this tools")
      end

  	end

})
