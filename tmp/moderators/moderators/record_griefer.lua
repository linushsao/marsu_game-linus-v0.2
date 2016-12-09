
-- Overriding in protection mods
old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	if not mymod:can_interact(pos, name) then
		return true
	end
	return old_is_protected(pos, name)
end

minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)

	if minetest.is_protected(pos, puncher) then
		--record to log
		--local puncher_name = puncher:get_player_name()
		--local mypos = minetest.pos_to_string(pos) -- Sets variable to (X,Y,Z.. where Y is up)
		local grifer_pos = {}
		local grifer_file = minetest.get_worldpath() .. "/grifer_file"
		local check_time = os.date("%H:%M")

		local player = minetest.get_player_by_name(puncher)
		local pos = player:getpos()

		grifer_pos[player:get_player_name()] = pos

		changed = true

		if changed then
			local output = io.open(grifer_file, "w")
				for i, v in pairs(grifer_pos) do
						output:write(check_time.."("..v.x..","..v.y..","..v.z..")"..i..node.name.."\n")
				end
				io.close(output)
				changed = false
		end

	end
end)
