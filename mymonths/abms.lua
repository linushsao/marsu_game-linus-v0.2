
--Places Snow on ground
if mymonths.snow_on_ground == true then

minetest.register_abm({
	nodenames = {"default:leaves", "default:dirt", "default:dirt_with_grass"},
	neighbors = {"air"},
	interval = 8,
	chance = 20,

	action = function (pos, node)

		local biome_jungle = minetest.find_node_near(pos, 5, "default:jungletree", "default:junglegrass")

		pos.y = pos.y + 1 -- check above node

		local na = minetest.get_node(pos)

		if (mymonths.weather == "snow" or mymonths.weather == "snowstorm")
		and biome_jungle == nil then

			if minetest.get_node_light(pos, 0.5) == 15
			and na.name == "air" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_1"})
			end
		end
	end
})

--Replace grass and flowers with snow
minetest.register_abm({
	nodenames = {"group:flora", "mymonths:puddle"},
	neighbors = {"air"},
	interval = 8,
	chance = 20,

	action = function (pos, node)

		local biome_jungle = minetest.find_node_near(pos, 5, "default:jungletree","default:junglegrass")

		if mymonths.weather == "snow"
		and biome_jungle == nil then

			if minetest.get_node_light({
				x = pos.x,
				y = pos.y + 1,
				z = pos.z}, 0.5) == 15 then

					minetest.set_node(pos, {name="mymonths:snow_cover_1"})
			end
		end
	end
})

-- Changes snow to larger snow
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1", "mymonths:snow_cover_2", "mymonths:snow_cover_3", "mymonths:snow_cover_4"},
	neighbors = {"default:dirt", "default:dirt_with_grass"},
	interval = 20,
	chance = 40,

	action = function (pos, node)

			if mymonths.weather2 == "snow"
			or mymonths.weather2 == "snowstorm" then

				if mymonths.weather2 == "snow"
				and math.random(1, 4) ~= 1 then
					return
				end

				if node.name == "mymonths:snow_cover_1" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_2"})

				elseif node.name == "mymonths:snow_cover_2" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_3"})

				elseif node.name == "mymonths:snow_cover_3" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_4"})

				elseif node.name == "mymonths:snow_cover_4" then

					minetest.set_node(pos, {name = "mymonths:snow_cover_5"})
				end
			end
	end
})

-- Snow Melting
minetest.register_abm({
	nodenames = {"mymonths:snow_cover_1", "mymonths:snow_cover_2", "mymonths:snow_cover_3", "mymonths:snow_cover_4", "mymonths:snow_cover_5"},
	interval = 10,
	chance = 1,

	action = function (pos, node)

		if mymonths.month_counter == 12
		or mymonths.month_counter == 1
		or mymonths.month_counter == 2 then
			return
		end

		-- remove snow if month is april
		if mymonths.month_counter == 4 then
			minetest.remove_node(pos)
			return
		end

		if math.random(1, 100) == 1 then

			if node.name == "mymonths:snow_cover_2" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_1"})

			elseif node.name == "mymonths:snow_cover_3" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_2"})

			elseif node.name == "mymonths:snow_cover_4" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_3"})

			elseif node.name == "mymonths:snow_cover_5" then

				minetest.set_node(pos, {name = "mymonths:snow_cover_4"})

			elseif node.name == "mymonths:snow_cover_1" then

				local nu = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

				if nu.name == "default:dirt_with_grass"
				or nu.name == "default:dirt" then

					minetest.set_node(pos, {name = "mymonths:puddle"})
				else
					minetest.remove_node(pos)
				end
			end
		end
	end
})

end -- END IF

if mymonths.use_puddles == true then

-- Makes Puddles when raining
minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	neighbors = {"default:air"},
	interval = 10,
	chance = 50,

	action = function (pos, node)

		if mymonths.weather == "rain" then

			-- return if puddle found nearby
			if minetest.find_node_near(pos, 20, "mymonths:puddle") then
				return
			end

			pos.y = pos.y + 1

			-- otherwise place puddle in empty space
			if minetest.get_node_light(pos, 0.5) == 15
			and minetest.get_node(pos).name == "air" then

				minetest.set_node(pos, {name = "mymonths:puddle"})
			end
		end
	end
})

-- Makes puddles dry up when not raining
minetest.register_abm({
	nodenames = {"mymonths:puddle"},
	neighbors = {"air"},
	interval = 5,
	chance = 5,

	action = function (pos, node)

		if mymonths.weather == "clear" then

			minetest.remove_node(pos)

		elseif mymonths.weather == "snow"
		or mymonths.weather == "snowstorm" then

			minetest.set_node(pos, {name = "mymonths:snow_cover_1"})

		end
	end
})

end -- END IF
