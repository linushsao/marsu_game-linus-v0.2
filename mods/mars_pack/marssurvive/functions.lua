--[[
minetest.register_abm({			-- making default plants grow on grass
	nodenames = {"default:dirt_with_grass"},
	interval = 40,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		if n=="air" or n=="marsair:air_stable" then
			local rnd=math.random(1,13)
			if rnd==1 then
				minetest.set_node(posu, {name = "default:junglegrass"})
			elseif (rnd==2 or rnd == 14 or rnd == 15) then
				minetest.set_node(posu, {name = "default:grass_" .. math.random(1,5)})
			elseif (rnd==3 or rnd == 16) then
				minetest.set_node(posu, {name = "farming:wheat_" .. math.random(4,8)})
			elseif rnd==4 then
				minetest.set_node(posu, {name = "farming:cotton_" .. math.random(4,8)})
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

if minetest.get_modpath("scifi_nodes") then
	minetest.register_abm({
	nodenames = {"marssurvive:clayblock"},
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
end
]]--


minetest.register_abm({
	nodenames = {"default:water_source"},
	neighbors = {"marssurvive:ice"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name = "marssurvive:ice"})
	end,
})
