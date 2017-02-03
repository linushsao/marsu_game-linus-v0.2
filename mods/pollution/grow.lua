local pollution_crystalsb="_block"
local pollution_crystalsd="_"
local pollution_crystals={
{"Coal","coal","lump"},
{"Steel","steel","ingot"},
{"Copper","copper","ingot"},
{"Bronze","bronze","ingot"},
{"Gold","gold","ingot"},
{"Mese","mese","_crystal"},
{"Diamond","diamond",""},
{"Obsidian","obsidian","_shard"}
}


for i, ob in pairs(pollution_crystals) do
if i==8 then pollution_crystalsb="" end
if i==6 then pollution_crystalsd="" end
minetest.register_node("pollution:crystal_" .. pollution_crystals[i][2], {
	description = pollution_crystals[i][1] .. " crystal",
	drawtype = "mesh",
	mesh = "pollution_crystal.obj",
	visual_scale = 1.0,
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {"default_" .. pollution_crystals[i][2] .. pollution_crystalsb ..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	damage_per_second = 5,
	walkable = false,
	is_ground_content = false,
	light_source=3,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.25, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3,not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="node" or pointed_thing.type=="nothing" then return itemstack end
		local pvp=minetest.setting_getbool("enable_pvp")
		local ob=pointed_thing.ref
		if ob:is_player() and pvp==false then return itemstack end
		ob:set_hp(ob:get_hp()-5)
		ob:punch(user, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:steel_pick", nil)
		return itemstack
		end,
})

minetest.register_craft({
	output = "default:" .. pollution_crystals[i][2] .. pollution_crystalsd .. pollution_crystals[i][3] ,
	recipe = {
		{"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2]},
		{"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2]},
		{"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2],"pollution:crystal_" .. pollution_crystals[i][2]}
	}
})

end

pollution_crystalsb=nil
pollution_crystalsd=nil
pollution_crystals=nil

minetest.register_node("pollution:crystal_magnesium", {
	description = "Magnesium crystal",
	drawtype = "mesh",
	mesh = "pollution_crystal.obj",
	visual_scale = 1.0,
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {"default_steel_block.png^pollution_dirt.png^pollution_dirt.png^pollution_dirt.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source=3,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.25, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3,not_in_creative_inventory=1},
})

minetest.register_craft({
	output = "pollution:magnesium_lump",
	recipe = {
		{"pollution:crystal_magnesium", "pollution:crystal_magnesium", "pollution:crystal_magnesium"},
		{"pollution:crystal_magnesium", "pollution:crystal_magnesium", "pollution:crystal_magnesium"},
		{"pollution:crystal_magnesium", "pollution:crystal_magnesium", "pollution:crystal_magnesium"}
	}
})


pollution_crystal_blocks_titles={"coal","copper","steel","bronze","magnesium","obsidian","gold","mese","diamond"}

pollution_crystal_blocks={
"default:coalblock",
"default:copperblock",
"default:steelblock",
"default:bronzeblock",
"pollution:magnesium_block",
"default:obsidian",
"default:goldblock",
"default:mese",
"default:diamondblock",
}



minetest.register_abm({
	nodenames = pollution_crystal_blocks,
	neighbors = {"pollution:water_source"},
	interval = 60,
	chance = 5,
	action = function(pos)
		local name=minetest.get_node(pos).name
		local pos1={x=pos.x,y=pos.y+1,z=pos.z}
		local level1=minetest.get_node(pos1).name=="pollution:water_source"
		if level1 then
				for i=1,9,1 do
					if name==pollution_crystal_blocks[i] then
						if math.random(i)==1 then
							minetest.set_node(pos1, {name = "pollution:crystal_" .. pollution_crystal_blocks_titles[i]})
						end
					break
					end
				end
		end
	end,
})