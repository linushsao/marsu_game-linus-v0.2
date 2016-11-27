
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


		-- February
		elseif tonumber(month) == 2 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- March
		elseif tonumber(month) == 3 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- April
		elseif tonumber(month) == 4 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- May
		elseif tonumber(month) == 5 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- June

		elseif 	tonumber(month) == 6 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- July
		elseif tonumber(month) == 7 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end
		-- August
		elseif 	tonumber(month) == 8 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- September
		elseif tonumber(month) == 9 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- October
		elseif tonumber(month) == 10 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- November
		elseif tonumber(month) == 11 then

			if math.random(1, 500) == 1 then
			lightning.strike()
			end

		-- December
		elseif tonumber(month) == 12 then

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

		local biome_jungle = minetest.find_node_near(ppos, 5, "default:jungletree", "default:junglegrass")
		local biome_desert = minetest.find_node_near(ppos, 5, "default:desert_sand", "default:desert_stone")
		local biome_snow = minetest.find_node_near(ppos, 5, "default:snow", "default:snowblock", "default:dirt_with_snow", "default:ice")

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

		-- slows players walk in snow
		if nodein.name == "mymonths:snow_cover_1" then

			player:set_physics_override(0.95, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_2" then

			player:set_physics_override(0.8, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_3" then

			player:set_physics_override(0.65, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_4" then

			player:set_physics_override(0.5, 1, 1, true, false)

		elseif nodein.name == "mymonths:snow_cover_5" then

			player:set_physics_override(0.35, 1, 1, true, false)
		else
			player:set_physics_override(1, 1, 1, true, false)
		end

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

		-- changes weather based on biome

		-- Jungle
		if biome_jungle ~= nil then

			if mymonths.weather == "snow" then

				mymonths.weather2 = "rain"

			elseif mymonths.weather == "snowstorm"
			or mymonths.weather == "hail" then

				mymonths.weather2 = "storm"
			end

		-- Desert
		elseif biome_desert ~= nil then

			if mymonths.weather == "snow"
			or mymonths.weather == "rain" then

				mymonths.weather2 = "clear"

			elseif mymonths.weather == "snowstorm"
			or mymonths.weather == "hail"
			or mymonths.weather == "storm" then

				mymonths.weather2 = "sandstorm"
			end

		-- Snow
		elseif biome_snow ~= nil then

			if mymonths.weather == "rain" then

				mymonths.weather2 = "snow"

			elseif mymonths.weather == "storm" then

				mymonths.weather2 = "snowstorm"
			end
		else
			mymonths.weather2 = mymonths.weather
		end

		if mymonths.weather2 == "storm" then

			minetest.add_particlespawner({
				amount = 40,
				time = 0.5,
				minpos = minp,
				maxpos = maxp,
				minvel = vel_rain,
				maxvel = vel_rain,
				minacc = acc_rain,
				maxacc = acc_rain,
				minexptime = 0.8,
				maxexptime = 0.8,
				minsize = 25,
				maxsize = 40,
				collisiondetection = false,
				vertical = true,
				texture = "weather_rain_dark.png",
				playername = name
			})

			if minetest.get_node_light({
				x = ppos.x,
				y = ppos.y + 1,
				z = ppos.z}, 0.5) == 15
			and mymonths.damage == true then

				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end

			if math.random(1, 200) == 1 then

				minetest.sound_play("mymonths_thunder", {
					pos = ppos,
					max_hear_distance = 10,
					gain = 10.0,
				})
			end

		elseif mymonths.weather2 == "rain" then

			minetest.add_particlespawner({
				amount = 15,
				time = 0.5,
				minpos = minp,
				maxpos = maxp,
				minvel = vel_rain,
				maxvel = vel_rain,
				minacc = acc_rain,
				maxacc = acc_rain,
				minexptime = 0.6,
				maxexptime = 0.8,
				minsize = 25,
				maxsize = 25,
				collisiondetection = false,
				vertical = true,
				texture = "weather_rain.png",
				playername = name
			})

		elseif mymonths.weather2 == "snow" then

			minetest.add_particlespawner({
				amount = 4,
				time = 0.5,
				minpos = minp,
				maxpos = maxp,
				minvel = vel_snow,
				maxvel = vel_snow,
				minacc = acc_snow,
				maxacc = acc_snow,
				minexptime = 4,
				maxexptime = 8,
				minsize = 15,
				maxsize = 25,
				collisiondetection = false,
				vertical = true,
				texture = "weather_snow.png",
				playername = name
			})

			minetest.add_particlespawner({
				amount = 4,
				time = 0.5,
				minpos = minp_deep,
				maxpos = maxp_deep,
				minvel = vel_snow,
				maxvel = vel_snow,
				minacc = acc_snow,
				maxacc = acc_snow,
				minexptime = 4,
				maxexptime = 6,
				minesize = 15,
				maxsize = 25,
				collisiondetection = false,
				vertical = true,
				texture = "weather_snow.png",
				playername = name
			})

		elseif mymonths.weather2 == "snowstorm" then

			minetest.add_particlespawner({
				amount = 25,
				time = 0.5,
				minpos = minp,
				maxpos = maxp,
				minvel = vel_snow,
				maxvel = vel_snow,
				minacc = acc_snow,
				maxacc = acc_snow,
				minexptime = 4,
				maxexptime = 6,
				minesize = 15,
				maxsize = 35,
				collisiondetection = false,
				vertical = true,
				texture = "weather_snow.png",
				playername = name
			})

			minetest.add_particlespawner({
				amount = 25,
				time = 0.5,
				minpos = minp_deep,
				maxpos = maxp_deep,
				minvel = vel_snow,
				maxvel = vel_snow,
				minacc = acc_snow,
				maxacc = acc_snow,
				minexptime = 4,
				maxexptime = 6,
				minesize = 15,
				maxsize = 25,
				collisiondetection = false,
				vertical = true,
				texture = "weather_snow.png",
				playername = name
			})

			if minetest.get_node_light({
				x = ppos.x,
				y = ppos.y + 1,
				z =ppos.z}, 0.5) == 15
			and mymonths.damage == true then

				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end

		elseif mymonths.weather2 == "sandstorm" then

			minetest.add_particlespawner({
				amount = 35,
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

		elseif mymonths.weather2 == "hail" then

			minetest.add_particlespawner({
				amount = 35,
				time = 0.5,
				minpos = minp,
				maxpos = maxp,
				minvel = vel_rain,
				maxvel = vel_rain,
				minacc = acc_rain,
				maxacc = acc_rain,
				minexptime = 1,
				maxexptime = 1,
				minesize = 5,
				maxsize = 10,
				collisiondetection = true,
				vertical = true,
				texture = "weather_hail.png",
				playername = name
			})

			if minetest.get_node_light({
				x = ppos.x,
				y = ppos.y + 1,
				z = ppos.z}, 0.5) == 15
			and mymonths.damage == true then

				if hp_t >= 15 then
					player:set_hp(hp - 1)
					hp_t = 0
				end
			end
		end

		biome_jungle = nil
		biome_snow = nil
		biome_desert = nil

	end
end)

local t2 = 0

minetest.register_globalstep(function(dtime)

	for _, player in ipairs(minetest.get_connected_players()) do

		local ppos = player:getpos()

		t2 = t2 + dtime

		if t2 < 1 then
			return
		end

		t2 = 0

		if mymonths.weather2 == "rain"
		or mymonths.weather2 == "storm" then

			minetest.sound_play("mymonths_rain1", {
				pos = ppos,
				max_hear_distance = 10,
				gain = 2.0,
			})
		end
	end
end)

--Puddle node
local puddle_box = {
	type  = "fixed",
	fixed = {
		{-0.1875, -0.5, -0.375, 0.125, -0.4875, 0.3125},
		{-0.25, -0.5, -0.3125, 0.3125, -0.4925, 0.25},
		{-0.3125, -0.5, -0.1875, 0.375, -0.4975, 0.1875},
	}
}

minetest.register_node("mymonths:puddle", {
	tiles = {"weather_puddle.png"},
	drawtype = "nodebox",
	paramtype = "light",
	pointable = false,
	buildable_to = true,
	alpha = 50,
	node_box = puddle_box,
	selection_box = puddle_box,
	groups = {not_in_creative_inventory = 1, crumbly = 3, attached_node = 0, falling_node = 1},
	drop = "",
})

--Snow Nodes
local snow = {
	{"mymonths:snow_cover_1","1", -0.4},
	{"mymonths:snow_cover_2","2", -0.2},
	{"mymonths:snow_cover_3","3", 0},
	{"mymonths:snow_cover_4","4", 0.2},
	{"mymonths:snow_cover_5","5", 0.5},
}
for i in ipairs(snow) do

	local itm = snow[i][1]
	local num = snow[i][2]
	local box = snow[i][3]

	minetest.register_node(itm, {
		tiles = {"weather_snow_cover.png"},
		drawtype = "nodebox",
		paramtype = "light",
		buildable_to = true,
		walkable = false,
		node_box = {
			type  = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}
		},
		selection_box = {
			type  = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, box, 0.5}
		},
		groups = {not_in_creative_inventory = 0, crumbly = 3, attached_node = 0, falling_node = 1},
		drop = "default:snow " .. num,
	})
end
