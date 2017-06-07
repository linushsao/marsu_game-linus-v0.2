
--configure
AUTOEAT_FILE = "autoeat_file" --filename of autoeat's configure
autoeat = {}

local function load_autoeat(file_name)
	local path_to = minetest.get_worldpath() .. "/"..file_name
	local input = io.open(path_to, "r")
	 if input == nil then return
	 else
	 autoeat = minetest.deserialize(input:read("*all"))
		 io.close(input)
	 end
 end

 load_autoeat(AUTOEAT_FILE)

--extra command
minetest.register_chatcommand("autoeat", {

	params = "Usage:autoeat <on/off>,default is off",
	description = "make players eat foods automatically",
	privs = {interact=true},

	func = function(name, param)
		if autoeat[name] == nil then autoeat[name] = "off" end
		if param == "on"	then
			autoeat[name]="on"
			save_table(autoeat,AUTOEAT_FILE)
			minetest.chat_send_player(name, "autoeat set to "..param.." .")
		elseif param == "off" then
			autoeat[name]="off"
			save_table(autoeat,AUTOEAT_FILE)
			minetest.chat_send_player(name, "autoeat set to "..param.." .")
		else
			minetest.chat_send_player(name, "wrong/nil param,Usage:autoeat <on/off>,default is off")
			minetest.chat_send_player(name, "current configure of autoeat is "..autoeat[name].." .")
--			print(dump(autoeat))
	  end
	end

})
