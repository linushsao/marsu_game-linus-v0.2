--about ABM

--stone -> mossucobble
minetest.register_abm({
	nodenames = {"marssurvive:cobble"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

minetest.register_abm({
	nodenames = {"marssurvive:stone"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

--water will be dry
minetest.register_abm({
	nodenames = {"default:water_source","default:water_flowing"},
	neighbors = {"marssurvive:sand"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
	end
})

--pollution water will be dry
minetest.register_abm({
	nodenames = {"pollution:water_source"},
	neighbors = {"marssurvive:sand"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
	end
})

--water will be FORZEN
minetest.register_abm({
	nodenames = {"default:water_source","default:water_flowing"},
	neighbors = {"marssurvive:ice"},
	interval = 30,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:ice"})
	end
})

-- bring scifi-plant into world
minetest.register_abm({
	nodenames = {"pollution:dirt"},
	interval = 120,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		print(n)
		if n=="air" or nd=="marssurvive:air2" then
			local rnd=math.random(1,18)
			if rnd==1 then
				minetest.set_node(posu, {name = "scifi_nodes:eyetree"})
			elseif rnd==2 then
				minetest.set_node(posu, {name = "scifi_nodes:flower1"})
			elseif rnd==3 then
				minetest.set_node(posu, {name = "scifi_nodes:flower2"})
			elseif rnd==4 then
				minetest.set_node(posu, {name = "scifi_nodes:flower3"})
			elseif rnd==5 then
				minetest.set_node(posu, {name = "scifi_nodes:flower4"})
			elseif rnd==6 then
				minetest.set_node(posu, {name = "scifi_nodes:gloshroom"})
			elseif rnd==7 then
				minetest.set_node(posu, {name = "scifi_nodes:grass"})
			elseif rnd==8 then
				minetest.set_node(posu, {name = "scifi_nodes:plant1"})
			elseif rnd==9 then
				minetest.set_node(posu, {name = "scifi_nodes:plant2"})
			elseif rnd==10 then
				minetest.set_node(posu, {name = "scifi_nodes:plant3"})
			elseif rnd==11 then
				minetest.set_node(posu, {name = "scifi_nodes:plant4"})
			elseif rnd==12 then
				minetest.set_node(posu, {name = "scifi_nodes:plant5"})
			elseif rnd==13 then
				minetest.set_node(posu, {name = "scifi_nodes:plant6"})
			elseif rnd==14 then
				minetest.set_node(posu, {name = "scifi_nodes:plant7"})
			elseif rnd==15 then
				minetest.set_node(posu, {name = "scifi_nodes:plant8"})
			elseif rnd==16 then
				minetest.set_node(posu, {name = "scifi_nodes:plant9"})
			elseif rnd==17 then
				minetest.set_node(posu, {name = "scifi_nodes:plant10"})
			elseif rnd==18 then
				minetest.set_node(posu, {name = "scifi_nodes:plant_trap"})

			end
		end
	end,
})


--pollution water will be clean
minetest.register_abm({
	nodenames = {"pollution:water_source"},
	neighbors = {"default:water_source","default:water_flowing"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:water_source"})
	end
})


--pollution dirt will be clean
minetest.register_abm({
	nodenames = {"pollution:dirt"},
	neighbors = {"default:water_source","default:water_flowing"},
	interval = 30,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:dirt"})
	end
})


