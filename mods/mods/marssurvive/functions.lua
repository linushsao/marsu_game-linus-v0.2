
-- clear player data
minetest.register_on_leaveplayer(function(player)
	marssurvive.player_sp[player:get_player_name()]=nil
end)

-- place air2 if near to it (or it will messup with corrently)
minetest.register_on_dignode(function(pos, oldnode, digger)
    		local np=minetest.find_node_near(pos, 1,{"marssurvive:air2"})
		if np~=nil then
			minetest.set_node(pos, {name = "marssurvive:air2"})
		end
end)
function marssurvive_replacenode(pos)
    	local np=minetest.find_node_near(pos, 1,{"marssurvive:air2"})
	if np~=nil then
		minetest.set_node(pos, {name = "marssurvive:air2"})
	else
		minetest.set_node(pos, {name = "air"})
	end
end



minetest.register_abm({			-- making default plants grow on grass
	nodenames = {"default:dirt_with_grass"},
	interval = 120,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		if n=="air" or nd=="marssurvive:air2" then
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

-- spread air gass in a level system
minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"marssurvive:air"},
	interval = 3,
	chance = 1,
	action = function(pos)
		local np=minetest.find_node_near(pos, 1,{"marssurvive:air"})
		local n
		if np~=nil then n=minetest.get_node(np) end
		if n and n.name=="marssurvive:air" then
			local r=minetest.get_meta(np):get_int("prl")
			if r>0 and r<marssurvive.air then
				minetest.set_node(pos, {name = "marssurvive:air"})
				minetest.get_meta(pos):set_int("prl",r+1)
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

minetest.register_abm({
	nodenames = {"marssurvive:air2"},
	neighbors = {"air"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name = "air"})
	end,
})