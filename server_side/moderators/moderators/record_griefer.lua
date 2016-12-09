
--[[
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	 if not areas:canInteract(pos, name) then
			return true
	 end
	 return old_is_protected(pos, name)
end
--]]

minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)


	local old_is_protected = minetest.is_protected
	local puncher_name = puncher:get_player_name()
	local pos = pos

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

		grifer_pos[puncher_name] = pos

		local changed = true

		if changed then
			local output = io.open(griefer_file, "a")
				for i, v in pairs(grifer_pos) do
						output:write("Time:"..check_time.."(CST),position:("..v.x..","..v.y..","..v.z.."),area_owner:"..table.concat(owners, ", ")..",griefer:"..i..",node:"..node.name.."\n")
--						print("finished io.open")

				end
				io.close(output)
				changed = false
		end

	end
end)
