marssurvive.flowers = {
	farming = {
		"flowers:mushroom_brown", "default:junglegrass",
		--wheat
		"farming:wheat_4", "farming:wheat_5", "farming:wheat_6",
		"farming:wheat_7", "farming:wheat_8", 
		--cotton
		"farming:cotton_4", "farming:cotton_5", "farming:cotton_6",
		"farming:cotton_7", "farming:cotton_8",
		--grass
		"default:grass_1", "default:grass_2", "default:grass_3", 
		"default:grass_4", "default:grass_5",
	},
	normal = {
		"flowers:mushroom_red", "flowers:rose", "flowers:tulip",
		"flowers:dandelion_yellow", "flowers:geranium", 
		"flowers:viola", "flowers:dandelion_white", 
		"default:papyrus",
	},
	scifi = {
		"scifi_nodes:eyetree", "scifi_nodes:flower1", 
		"scifi_nodes:flower2", "scifi_nodes:flower3",
		"scifi_nodes:flower4", "scifi_nodes:gloshroom", 
		"scifi_nodes:grass", "scifi_nodes:plant1",
		"scifi_nodes:plant2", "scifi_nodes:plant3", 
		"scifi_nodes:plant4", "scifi_nodes:plant5", 
		"scifi_nodes:plant6", "scifi_nodes:plant7", 
		"scifi_nodes:plant8", "scifi_nodes:plant9",
		"scifi_nodes:plant10", "scifi_nodes:plant_trap",
	}
}

if minetest.get_modpath("farming_plus") then
	local farming_plus = {
		"farming_plus:potato", "farming_plus:tomato", 
		"farming_plus:strawberry", "farming_plus:rhubarb", 
		"farming_plus:orange", "farming_plus:carrot", 
		"farming:pumpkin", 
	}
	for _, flower in pairs(farming_plus) do
		table.insert(marssurvive.flowers.farming, flower)
	end
end


for _, flower in pairs(marssurvive.flowers.farming) do
	print("add to plant group: "..flower)
	local def = minetest.registered_nodes[flower]
	local groups = table.copy(def.groups)
	groups.plant = 1
	minetest.override_item(flower, { groups=groups })
end

for _, flower in pairs(marssurvive.flowers.normal) do
	local def = minetest.registered_nodes[flower]
	local groups = table.copy(def.groups)
	groups.plant = 1
	minetest.override_item(flower, { groups=groups })
end

for _, flower in pairs(marssurvive.flowers.scifi) do
	local def = minetest.registered_nodes[flower]
	local groups = table.copy(def.groups)
	groups.plant = 1
	minetest.override_item(flower, { groups=groups })
end

minetest.register_abm({			-- making default plants grow on grass
	nodenames = {"default:dirt_with_grass"},
	interval = 40,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		if minetest.find_node_near(posu, 1, "group:plant") then
			return
		end
		if n=="air" or n=="marsair:air_stable" then
			local rnd=math.random(1,3)
			if rnd == 1 then
			  --normal
			  local rnd=math.random(1,#marssurvive.flowers.normal)
			  minetest.set_node(posu, 
			  	{name = marssurvive.flowers.normal[rnd]})
			else
			  --farming
			  local rnd=math.random(1,#marssurvive.flowers.farming)
			  minetest.set_node(posu, 
			  	{name = marssurvive.flowers.farming[rnd]})
			  print("place node: "..marssurvive.flowers.farming[rnd])
			end
		end
	end,
})

if minetest.get_modpath("scifi_nodes") then
    minetest.register_abm({		-- making scifi plants grow on clay
	nodenames = {"marssurvive:clayblock"},
	interval = 200,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		local light = minetest.get_node_light(posu)
		if (light == nil) or (light < default.LIGHT_MAX-1) then
		return end
		if minetest.find_node_near(posu, 1, "group:plant") then
		return end
		if n=="air" or n=="marsair:air_stable" then
			--normal
			local rnd=math.random(1,#marssurvive.flowers.scifi)
			minetest.set_node(posu, 
				{name = marssurvive.flowers.scifi[rnd]})
		end
	end,
    })
end


