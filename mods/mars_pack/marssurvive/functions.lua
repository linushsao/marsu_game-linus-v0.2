
minetest.register_abm({			-- making default plants grow on grass
	nodenames = {"default:dirt_with_grass"},
	interval = 120,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		if n=="air" or n=="marsair:air_stable" then
			local rnd=math.random(1,13)
			if rnd==1 then
				minetest.set_node(posu, {name = "default:junglegrass"})
			elseif rnd==2 then
				minetest.set_node(posu, {name = "default:grass_" .. math.random(1,5)})
			elseif rnd==3 then
				minetest.set_node(posu, {name = "farming:wheat_" .. math.random(1,8)})
			elseif rnd==4 then
				minetest.set_node(posu, {name = "farming:cotton_" .. math.random(1,8)})
			elseif rnd==5 then
				minetest.set_node(posu, {name = "flowers:mushroom_brown"})
			elseif rnd==6 then
				minetest.set_node(posu, {name = "flowers:mushroom_red"})
			elseif rnd==7 then
				minetest.set_node(posu, {name = "flowers:rose"})
			elseif rnd==8 then
				minetest.set_node(posu, {name = "flowers:tulip"})
			elseif rnd==9 then
				minetest.set_node(posu, {name = "flowers:dandelion_yellow"})
			elseif rnd==10 then
				minetest.set_node(posu, {name = "flowers:geranium"})
			elseif rnd==11 then
				minetest.set_node(posu, {name = "flowers:viola"})
			elseif rnd==12 then
				minetest.set_node(posu, {name = "flowers:dandelion_white"})
			elseif rnd==13 then
				minetest.set_node(posu, {name = "default:papyrus"})
			end
		end
	end,
})


-- in this case is the default air the vacuum, and air2 is air
minetest.register_abm({
	nodenames = {"default:water_source"},
	neighbors = {"marssurvive:ice"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name = "marssurvive:ice"})
	end,
})