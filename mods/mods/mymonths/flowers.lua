
-- Flowers die in late fall
minetest.register_abm({
--	nodenames = {'group:flower'},
  nodenames = {'group:flower','group:farming'},
	interval = 10,
	chance = 10,

	action = function (pos)

		if mymonths.month_counter == 10
		or mymonths.month_counter == 11 then

			minetest.set_node(pos, {name = 'default:dry_grass_1'})
		end
	end
})

-- Flowers grow in spring, flower spread ABM is in flower mod, this just gives
-- initial population as that ABM won't grow flowers where there are none.
minetest.register_abm({
	nodenames = {'group:soil'},
	interval = 240,
	chance = 100,

	action = function (pos)

		-- return if not march or april
		if mymonths.month ~= 3
		or mymonths.month ~= 4 then
			return
		end

		local pos0 = {x = pos.x - 4, y = pos.y - 4, z = pos.z - 4}
		local pos1 = {x = pos.x + 4, y = pos.y + 4, z = pos.z + 4}
		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flower")

		if #flowers > 2 then
			return
		end

		pos.y = pos.y + 1

		if minetest.get_node(pos).name == 'air' then

			local key = math.random(1, 6)

			if key == 1 then

				minetest.set_node(pos, {name = 'flowers:dandelion_white'})

			elseif key == 2 then

				minetest.set_node(pos, {name = "flowers:dandelion_yellow"})

			elseif key == 3 then

				minetest.set_node(pos, {name = "flowers:geranium"})

			elseif key == 4 then

				minetest.set_node(pos, {name = "flowers:rose"})

			elseif key == 5 then

				minetest.set_node(pos, {name = "flowers:tulip"})

			elseif key == 6 then

				minetest.set_node(pos, {name = "flowers:viola"})
			end
		end
	end
})
