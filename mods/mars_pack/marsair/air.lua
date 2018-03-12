minetest.register_node("marsair:air_stable", {
	description = "Air (stable) [You Hacker!]",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 20, r = 220, g = 200, b = 200},
	tiles = {"marssurvive_air.png^[colorize:#E0E0E033"},
	alpha = 0.1,
	groups = {marsair=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
})

minetest.register_node("marsair:air", {
	description = "Air (unstable)",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 180, r = 120, g = 120, b = 120},
	alpha = 20,
	tiles = {"marssurvive_air.png^[colorize:#E0E0E0CC"},
	groups = {marsair=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(30)
	end,
	on_timer = function (pos, elapsed)
		minetest.set_node(pos, {name = "marsair:air_stable"})
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		itemstack:clear()
		return itemstack
		--dropper:get_inventory():remove_item("main", itemstack)
	end
})

-- place air_stable if near to it (or it will messup with corrently)
minetest.register_on_dignode(function(pos, oldnode, digger)
    		local np=minetest.find_node_near(pos, 1,{"marsair:air_stable"})
		if np~=nil then
			minetest.set_node(pos, {name = "marsair:air_stable"})
		end
end)

--air dissappear next to vacuum
minetest.register_abm({
	nodenames = {"marsair:air_stable"},
	neighbors = {"air"},
	interval = marsairconfig.vacuum_leak_speed,
	chance = 1,
	action = function(pos)
		air_pos = minetest.find_node_near(pos, 1, "air")
		minetest.log("action", "airleak1 at pos: "..pos.x..","..pos.y..
		","..pos.z.." by: "..air_pos.x..","..airpos.y..","..airpos.z)
		if math.random(marsairconfig.vacuum_leak_chance) == 1 then
			minetest.set_node(pos, {name = "air"})
			return
		end
		minetest.after(0.1, function(pos)
			local positions_over = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y+1, z=pos.z-1}, 
						{x=pos.x+1, y=pos.y+1, z=pos.z+1}, "air")
			local positions_nextto =minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, 
						{x=pos.x+1, y=pos.y, z=pos.z+1}, "air")
			if positions_over and #positions_over >= 1 then
				local new_pos = positions_over[math.random(#positions_over)]
				minetest.set_node(pos, {name = "air"})
				if math.random(5) ~= 1 then
					minetest.set_node(new_pos, {name = "marsair:air_stable"})
				end
			elseif positions_nextto and #positions_nextto >= 1 then
				local new_pos = positions_nextto[math.random(#positions_nextto)]
				minetest.set_node(pos, {name = "air"})
				if math.random(10) ~= 1 then
					minetest.set_node(new_pos, {name = "marsair:air_stable"})
				end
			end
		end, pos)
	end,
})

--airleak after  1.5 days:
function airgen_removeone(pos)
	local inv = minetest.get_inventory({type="node", pos=pos})
	local needed_air = {name="marsair:air", count=marsairconfig.need_air_fixleak_count, 
					wear=0, metadata=""}
	if inv:contains_item("main", needed_air) then
		inv:remove_item("main", needed_air)
		return true
	end
	return false
end
		
function air_leak(pos)
	--print('\n\nAIRLEAK')
	if minetest.find_node_near(pos, 20, "marsair:airgen_admin") then return end
	local gene_pos = minetest.find_node_near(pos, 20, "marsair:airgen")

	-- if there is no airgen, then leak else search for connection to it
	if gene_pos == nil then 
		--print('NO AIRGEN')
		minetest.set_node(pos, {name = "air"}) 
		return false
	end

	-- allow only one leak per abm interval and airgenerator
	local meta = minetest.get_meta(gene_pos)
	local dtime = minetest.get_gametime()-meta:get_int("leak")
	if (dtime > 4) then
		meta:set_int("leak", minetest.get_gametime())
	else
		return
	end
	
	-- if there is content ignore near, return, because u don't know
	-- whether there can be an generator near
	if minetest.find_node_near(pos, 20, "ignore") then return end
	

	local start_poss = minetest.serialize(pos)
	--print('START POSS', start_poss)
	local found = {}
	found[start_poss] = 1
	local actual = {}
	actual[start_poss] = 1
	local new = {}
	local step = 0
	while (step <= 20) and (actual ~= {}) do
		--print('NEWSTEP: ', step)
		for aposs, _ in pairs(actual) do
			local apos = minetest.deserialize(aposs)
			local nodes = {"marsair:air_stable", "marsair:airgen"}
			for _, npos in pairs(minetest.find_nodes_in_area({x=apos.x-1, y=apos.y-1, z=apos.z-1}, 
						{x=apos.x+1, y=apos.y+1, z=apos.z+1}, nodes)) do
				local nposs = minetest.serialize(npos)
				if found[nposs] == nil then
					found[nposs] = 1
					local node_name = minetest.get_node(npos).name
					if node_name == "marsair:air_stable" then
						new[nposs] = 1
					elseif node_name == "marsair:airgen" then
						if not airgen_removeone(gene_pos) then
minetest.log("action", "airleak2 at pos: "..pos.x..","..pos.y..","..pos.z)
							minetest.set_node(pos, {name = "air"})
						end
						return
					end
				end
			end
		end
		actual = new
		new = {}
		step = step +1
	end
	minetest.set_node(pos, {name = "air"}) 
end
--
--only 1/8 of the nodes are accessed per try,
--so 1.5d/8 is interval, chance = 8
--1.5d = 30 secs, using normal speed
minetest.register_abm({
	nodenames = {"marsair:air_stable"},
	interval = marsairconfig.leak_time,
	chance = marsairconfig.leak_chance,
	action = function(pos)
		air_leak(pos)
	end,
})


--backwards-compatiblity:
minetest.register_alias("marssurvive:air", "marsair:air")
minetest.register_alias("marssurvive:air2", "marsair:air_stable")
