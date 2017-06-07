--
md0_config = false

--check mods
if minetest.get_modpath("moderators") ~= nil then md0_config = true end

--other script
dofile(minetest.get_modpath("linus_added") .. "/functions.lua")
dofile(minetest.get_modpath("linus_added") .. "/command.lua")
dofile(minetest.get_modpath("linus_added") .. "/alias.lua")
dofile(minetest.get_modpath("linus_added") .. "/craft.lua")
dofile(minetest.get_modpath("linus_added") .. "/ores.lua")
dofile(minetest.get_modpath("linus_added") .. "/abm.lua")

--skycolor change by time
day_timer = 0

--[[minetest.register_globalstep(function(dtime)

	day_timer=day_timer+dtime
	if day_timer<2 then return end

	day_timer=0

	local ratio = minetest.get_timeofday() --linus added
--		print("TIME RATOI in globalsetup BEFORE:"..ratio)
		for i, player in pairs(minetest.get_connected_players()) do
			local pos=player:getpos().y
			if pos<=1000 then

				sky_change(player,ratio)

			end
		end

end)]]--

--show formspace of wiki to un-interact players automatically every 3 seconds
local wiki_timer = 0

wiki_show = {}

minetest.register_globalstep(function(dtime)

	wiki_timer=wiki_timer+dtime

	if wiki_timer<5 then return end
	wiki_timer=0
	local v1,vv

	for v1,vv in ipairs(wiki_pos) do --pick wikinod's position to get_objects
		local all_objects = {}
		local _,obj

		all_objects[v1] = minetest.get_objects_inside_radius({x=vv.x, y=vv.y, z=vv.z},3)
		if #all_objects[v1] ~= 0 then print("#all_objects :"..v1.."##"..dump(all_objects[v1]))
		else
	--		print("wiki node "..v1.." detect no object")
			wiki_show[v1] = {}
		end

		if wiki_show[v1] ~= nil then
			for v11,vvv in ipairs(wiki_show[v1]) do --check if players leave
				if all_objects[v1][v11] == nil then
					table.remove(wiki_show[v1],v11)
					print("player "..v11.."leave")
				end
			end
		end

		for _,obj in ipairs(all_objects[v1]) do
			if obj:is_player() then
				print("players found :"..obj:get_player_name())
				if wiki_show[v1] == nil then wiki_show[v1]={} end
				if wiki_show[v1][obj:get_player_name()] == nil then --never show wiki
					wiki_show[v1][obj:get_player_name()] = true
					print(v1.." show to "..obj:get_player_name())
				elseif wiki_show[v1][obj:get_player_name()] == true then
					wiki_show[v1][obj:get_player_name()] = false --had show
					print(v1.." had show to "..obj:get_player_name())
				elseif wiki_show[v1][obj:get_player_name()] == false then
					print(v1.." had show to "..obj:get_player_name())
				end
				print("player: "..obj:get_player_name())
				if wiki_show[v1][obj:get_player_name()] then
					wikilib.show_wiki_page(obj:get_player_name(), "Main")
				end
			end
		end
	end
--	print("wiki_pos "..dump(wiki_pos))
end)

minetest.register_on_shutdown(function()
	save_table(wiki_pos,"wiki_pos_file")
end)