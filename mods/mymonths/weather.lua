
--Sets the weather types for each month
local t = 0

minetest.register_globalstep(function(dtime)

	local month = mymonths.month_counter

	t = t + dtime

	if t < 5 then
		return
	end

	t = 0

	if minetest.get_modpath("lightning") then
		if mymonths.weather == "sandstorm" then
		lightning.strike()
		end
	end

	if mymonths.weather ~= "clear" then

		if math.random(1, 100) == 1 then

			mymonths.weather = "clear"
			minetest.chat_send_all("Clear skys!")
		end
	else

--		minetest.chat_send_all(tonumber(month))

		-- January

		if tonumber(month) == 1 then

			if math.random(1, 500) == 1 then
				mymonths.weather = "sandstorm"
				minetest.chat_send_all("It is sandstorm of MARS")
			end
		else
			if math.random(1, 500) == 1 then
			lightning.strike()
			end
		end
	end
end)

-- Weather vectors and some particles are from jeija's weather mod
addvectors = function (v1, v2)
	return {x = v1.x + v2.x, y = v1.y + v2.y, z = v1.z + v2.z}
end

hp_t = 0

minetest.register_globalstep(function(dtime)

	hp_t = hp_t + dtime

	if hp_t <= 0.2 then
		return
	end

	mymonths.weather2 = mymonths.weather

	for _, player in ipairs(minetest.get_connected_players()) do

		local ppos = player:getpos()
		local hp = player:get_hp()
		local name = player:get_player_name()
		local nodein = minetest.get_node(ppos)
		local nodeu = minetest.get_node({x = ppos.x, y = ppos.y - 1, z = ppos.z})

		local minp = addvectors(ppos, {x = -10, y = 7, z = -10})
		local maxp = addvectors(ppos, {x = 10, y = 7, z = 10})
		local minps = addvectors(ppos, {x =-15, y = 0, z = -10})
		local maxps = addvectors(ppos, {x = 5, y = 3, z = 10})
		local minp_deep = addvectors(ppos, {x = -10, y = 3.2, z = -10})
		local maxp_deep = addvectors(ppos, {x = 10, y = 2.6, z = 10})
		local vel_rain = {x = 0, y = -4, z = 0}
		local acc_rain = {x = 0, y = -9.81, z = 0}
		local vel_snow = {x = 0, y = -0.4, z = 0}
		local acc_snow = {x = 0, y = -0.5, z = 0}
		local vel_sand = {x = 1, y = -0.1, z = 0}
		local acc_sand = {x = 2, y = 0, z = 0}

		-- check light to make sure player is outside
		if minetest.get_node_light({
			x = ppos.x,
			y = ppos.y + 1,
			z = ppos.z}, 0.5) ~= 15 then

			return
		end

		-- checks if there is any weather
		if mymonths.weather2 == "none" then
			return
		end

		if mymonths.weather2 == "sandstorm" then

			minetest.add_particlespawner({
				amount = 5,
				time = 0.5,
				minpos = minps,
				maxpos = maxps,
				minvel = vel_sand,
				maxvel = vel_sand,
				minacc = acc_sand,
				maxacc = acc_sand,
				minexptime = 4,
				maxexptime = 4,
				minesize = 5,
				maxsize = 10,
				collisiondetection = false,
				vertical = true,
				texture = "weather_sand.png",
				playername = name
			})

			if minetest.get_node_light({
				x = ppos.x,
				y = ppos.y + 1,
				z = ppos.z}, 0.5) == 15
			and mymonths.damage == true then

				if hp_t >= 15 then
					player:set_hp(hp - 6)
					hp_t = 0
				end
			end
		end
	end
end)

local t2 = 0