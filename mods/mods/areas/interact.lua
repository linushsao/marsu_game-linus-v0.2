
-- from juli&Gundul
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	 if not areas:canInteract(pos, name) then
			return true
	 end
	 return old_is_protected(pos, name)
end

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

				 player:setpos({x=-408, y=-4180, z=-97}) --- teleport to Coordinate x,y,z

	 end
end)
