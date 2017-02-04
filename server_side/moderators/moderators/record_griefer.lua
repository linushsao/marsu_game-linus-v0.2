
--[[
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	 if not areas:canInteract(pos, name) then
			return true
	 end
	 return old_is_protected(pos, name)
end
--]]

--record the puncher,but puncher maybe just punch not get node.
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)

	if (pos == nil or node == nil or puncher == nil or pointed_thing == nil) then
	return true
	end


	local old_is_protected = minetest.is_protected
	local puncher_name = puncher:get_player_name()
	local pos = pos
	local font_color = ""

--[[
	print("on_punchnode outside")
	print("########################################")
	print("check_areas:canInteract "..dump(areas:canInteract(pos, puncher)))
	print("check pos:"..dump(pos))
	print("check node:"..dump(node))
	print("check puncher:"..puncher_name)
	print("check pointed_thing:"..dump(pointed_thing))
--]]

	if not areas:canInteract(pos, puncher) then
--		 print("on_punchnode inside")
		--record to log
		--local puncher_name = puncher:get_player_name()
		--local mypos = minetest.pos_to_string(pos) -- Sets variable to (X,Y,Z.. where Y is up)
		local grifer_pos = {}
		local griefer_file = minetest.get_worldpath() .. "/griefer_file"
		local check_time = os.date("%x %H:%M")
		local owners = areas:getNodeOwners(pos)
		local check_area = false

		for _, v in pairs(owners) do
				if v == puncher_name then check_area = true end
		end
--		print(dump(check_area))

		if not check_area then font_color = "red" end
--		print(font_color)

		grifer_pos[puncher_name] = pos

		local changed = true

		if changed then
			local output = io.open(griefer_file, "a")
				for i, v in pairs(grifer_pos) do
						output:write("<font color="..font_color..">".."Time:"..check_time.."(CST),position:("..v.x..","..v.y..","..v.z.."),area_owner:"..table.concat(owners, ", ")..",puncher:<b>"..i.."</b>,node:"..node.name.."</font><br> \n ")
--						print("finished io.open")

				end
				io.close(output)
				changed = false
		end

	end
end)


--record the digger,digger means really get node.
minetest.register_on_dignode(function(pos, oldnode, digger)

	if (digger == nil or pos == nil or oldnode == nil) then
	return true
	end

		local old_is_protected = minetest.is_protected
		local digger_name = digger:get_player_name()
		local pos = pos
		local check_area = false
--[[
		print("on_dignode outside")
		print("########################################")
		print("check_areas:canInteract "..dump(areas:canInteract(pos, digger)))
		print("check pos:"..dump(pos))
		print("check node:"..dump(oldnode))
		print("check puncher:"..digger_name)
--]]
		if not areas:canInteract(pos, digger) then
--			 print("on_dignode inside")
			--record to log
			--local puncher_name = puncher:get_player_name()
			--local mypos = minetest.pos_to_string(pos) -- Sets variable to (X,Y,Z.. where Y is up)
			local grifer_pos = {}
			local griefer_file = minetest.get_worldpath() .. "/griefer_file"
			local check_time = os.date("%x %H:%M")
			local owners = areas:getNodeOwners(pos)

			for _, v in pairs(owners) do
					if v == digger_name then check_area = true end
			end
--			print(dump(check_area))

			grifer_pos[digger_name] = pos

			local changed = true

			if changed then
				local output = io.open(griefer_file, "a")
					for i, v in pairs(grifer_pos) do
						if check_area then
							output:write("Time:"..check_time.."(CST),position:("..v.x..","..v.y..","..v.z.."),area_owner:"..table.concat(owners, ", ")..",digger:<b>"..i.."</b>,node:"..oldnode.name.."<br> \n ")
						else
						--<span style="color:#FFFFFF; background-color:#000000">
							output:write("<span style="..'\"'.."color:#FFFFFF; background-color:#000000"..'\">'.."Time:"..check_time.."(CST),position:("..v.x..","..v.y..","..v.z.."),area_owner:"..table.concat(owners, ", ")..",digger:<font color=red><b>"..i.."</b></font>,node:"..oldnode.name.."</span><br> \n ")
--							print("finished io.open")
						end
					end
					io.close(output)
					changed = false
			end

		end


end)

--record the pollution_water placed by players.
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if newnode ~= nil and newnode.name == "pollution:water_source" then
			local griefer_file = minetest.get_worldpath() .. "/griefer_file"
			local check_time = os.date("%x %H:%M")
			local output = io.open(griefer_file, "a")

--							output:write("<font color="..font_color..">".."Time:"..check_time.."(CST),position:("..v.x..","..v.y..","..v.z.."),area_owner:"..table.concat(owners, ", ")..",puncher:<b>"..i.."</b>,node:"..node.name.."</font><br> \n ")
					output:write("Time:"..check_time.."(CST),position:"..  minetest.pos_to_string(pos) .. ",Node " .. newnode.name .. " placed by " .. placer:get_player_name().."<br> \n ")
					io.close(output)
			end
  --      print("Node " .. newnode.name .. " at " ..  minetest.pos_to_string(pos) .. " placed by " .. placer:get_player_name())
end)
