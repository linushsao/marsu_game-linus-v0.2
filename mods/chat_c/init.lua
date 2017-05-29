meta_allplayer = {}
local rgbcolor = {
  {"g","green",3},
  {"b","blue",3},
  {"lg","lightgreen",4},
  {"lb","lightblue",4},
  {"p","pink",3},
  {"y","yellow",3},
  {"gr","GREENYELLOW",4},
  {"pu","PURPLE",4},
  {"go","GOLD",4},
  {"m","MAGENTA",3},
  {"c","CHOCOLATE",3},
  {"cy","CYAN",4},
  {"w","",3}
}

function save_chatc_config()
			local chatc_config_file = minetest.get_worldpath() .. "/chatc"
			local output = io.open(chatc_config_file, "w")
			if output == nil then return end
			output:write(minetest.serialize(meta_allplayer).."\n")
			io.close(output)
end

local function loadchatc()
	local chatc_file = minetest.get_worldpath() .. "/chatc"
	local input = io.open(chatc_file, "r")
    if input == nil then return
    else
     meta_allplayer = minetest.deserialize(input:read("*all"))
     io.close(input)
    end
end

loadchatc()

minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
  if meta_allplayer[playername] == nil then
      meta_allplayer[playername]={}
      meta_allplayer[playername].chatc_echo = false
			meta_allplayer[playername].prefix_color = rgbcolor[math.random(1,#rgbcolor)][2]
  end
end)


minetest.register_on_chat_message(function(name, message)
  if minetest.get_player_privs(name).interact == true then
    local msg = ""
    local checkit=false

    for _, row in ipairs(rgbcolor) do --check if new colored
      if string.find(message, row[1].." ") == 1 then
        checkit = true
        meta_allplayer[name].prefix_color = row[2]
        msg = core.colorize(meta_allplayer[name].prefix_color, "<" .. name .. "> " .. string.sub(message,row[3]))
      end
    end
    if checkit == false then --check if use old colored
      msg = core.colorize((meta_allplayer[name].prefix_color or ""), "<" .. name .. "> " .. message)
    end
--    print(dump(meta_allplayer))

    for _,player in ipairs(minetest.get_connected_players()) do
    	local user = player:get_player_name()
      if not(meta_allplayer[name].chatc_echo == false and user == name) then
        minetest.chat_send_player(user,msg)
      end
    end
  end
  return true

end)

minetest.register_chatcommand("warnings", {
   params = "Usage: warnings <TEXT>",
   description = "Send red message by managers",
   privs = {basic_privs=true},
   func = function(name, param)
      local msg = core.colorize("red", param);
      minetest.chat_send_all(msg);
   end,
})

minetest.register_chatcommand("chatconf", {
   params = "chatconf <PARAM> , <PARAM> = empty/echo-on/echo-off,empty means show COLOR-Sheet,echo-on means repeat both plain-msg&colored msg,echo-off means print only plain-msg for you and others see colored msg",
   description = "chat-c configure",
   privs = {interact=true},
   func = function(name, param)
     local msg = ""

     if param == "echo-on" then
        meta_allplayer[name].chatc_echo = true
        minetest.chat_send_player(name, "**"..name..": chat_echo is enable.")
      elseif param == "echo-off" then
        meta_allplayer[name].chatc_echo = false
        minetest.chat_send_player(name, "**"..name..": chat_echo is disable.")
      else
        minetest.chat_send_player(name, "===Sheet of CODE/COLOR===")
        for _, row in ipairs(rgbcolor) do
          msg = core.colorize(row[2],row[2])
          minetest.chat_send_player(name, row[1].." "..msg)
        end
        minetest.chat_send_player(name, "===============")
        minetest.chat_send_player(name,"**".. name..", your chatc_echo is "..tostring(meta_allplayer[name].chatc_echo))
				minetest.chat_send_player(name,"**colored msg: <CODE> <MESSAGE> ,<CODE> is only needed at first time in chat,server will remember it.")

      end

   end,
})

minetest.register_on_shutdown(function()
--recovery_md0_privs() --recovery supervisors's privs
	save_chatc_config()
	minetest.log("action","MOD:chatc_config of chatc saved.")

end)
