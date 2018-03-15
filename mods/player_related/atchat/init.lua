--comments have not been removed
--[[ All code around the messaging system should be kept here. ]]--
atchat_lastrecv = {}

--now: new stuff: register_on_chat_message
minetest.register_on_chat_message(function(name, message)
	local players, msg=string.match(message, "^@([^%s:]*)[%s:](.*)")
	if players and msg then
		if msg == "" then
			minetest.chat_send_player(name, "You have to say something!")
		else
			if players=="" then--reply
				-- We need to get the target
				players = atchat_lastrecv[name]
			end
			if players and players ~= "" then
				for target in string.gmatch(","..players..",", ",([^,]+),") do
					-- Checking if the target exists
					if not minetest.get_player_by_name(target) then
						minetest.chat_send_player(name, ""..target.." is not online!")
					else
						-- Sending the message
						minetest.chat_send_player(target, string.format("(%s) %s", name, message))
						
					end
				end
				-- Register the chat in the target persons lastspoke tabler
				atchat_lastrecv[name] = players
			else
				minetest.chat_send_player(name, "Nobody you've spoken to yet!")
			end
		end
		return true
	end
end)