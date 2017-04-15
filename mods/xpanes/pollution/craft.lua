minetest.register_craft({
	output = "pollution:pchest",
	recipe = {
		{"default:stick","default:stick","default:stick"},
		{"default:stick","default:chest_locked", "default:stick"},
		{"default:stick","default:stick","default:stick"},
	}
})

minetest.register_craft({
	output = "pollution:yrifle",
	recipe = {
		{"default:steel_ingot","pollution:syra_bucket", "pollution:magnesium_ingot"},
		{"","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "pollution:crifle",
	recipe = {
		{"pollution:crystal_small","pollution:crystal_block", "pollution:magnesium_ingot"},
		{"","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "pollution:nrifle",
	recipe = {
		{"pollution:kvaveoxid_lump", "pollution:ice", "pollution:magnesium_ingot"},
		{"","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "pollution:trifle",
	recipe = {
		{"pollution:koloxid_lump", "pollution:toxic_bucket", "pollution:magnesium_ingot"},
		{"","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "pollution:bottle 10",
	recipe = {
		{"default:glass", "pollution:kalium_lump", "default:glass"},
		{"","default:glass",""},
	}
})

minetest.register_craft({
	output = "pollution:bottlepur",
	recipe = {
		{"pollution:bottle", "pollution:bottle", "pollution:bottle"},
	}
})


minetest.register_craft({
	output = "pollution:magnesium_lump",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal_fragment", "default:coal_lump"},
		{"","default:stone",""},
	}
})

minetest.register_craft({
	output = "pollution:kalium_lump",
	recipe = {
		{"default:steel_ingot", "pollution:toxic_bucket", "default:mese_crystal_fragment"},
		{"","group:leaves",""},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "pollution:magnesium_ingot",
	recipe = "pollution:magnesium_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "pollution:magnesium_ingot",
	recipe = "pollution:magnesium_lump",
})

minetest.register_craft({
	output = "pollution:magnesium_block",
	recipe = {
		{"pollution:magnesium_ingot", "pollution:magnesium_ingot", "pollution:magnesium_ingot"},
		{"pollution:magnesium_ingot", "pollution:magnesium_ingot", "pollution:magnesium_ingot"},
		{"pollution:magnesium_ingot", "pollution:magnesium_ingot", "pollution:magnesium_ingot"},
	}
})

minetest.register_craft({
	output = "pollution:magnesium_lump 9",
	recipe = {{"pollution:magnesium_block"}}
})


minetest.register_node("pollution:magnesium_lump", {
	description = "Magnesium lump",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"pollution_lump1.png"},
	inventory_image = "pollution_lump1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy = 3, dig_immediate = 3,},

	on_use = function(itemstack, user, pointed_thing)
	pollution_unsetsicknes(user,false,1)
	itemstack:take_item()
	user:set_hp(user:get_hp()+10)
		return itemstack
		end,
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pollution:magnesium_block", {
	description = "Magnesium block",
	tiles = {"default_steel_block.png^pollution_dirt.png^pollution_dirt.png^pollution_dirt.png"},
	groups = {cracky = 3,},
	sounds = default.node_sound_stone_defaults(),
})



minetest.register_craftitem("pollution:magnesium_ingot", {
	description = "Magnesium ingot",
	inventory_image = "pollution_ingot1.png",
})

minetest.register_craftitem("pollution:kalium_lump", {
	description = "Kalium lump",
	inventory_image = "pollution_lump5.png",
})





local pollution_craft={
{"pollution:nbucket","pollution:kvaveoxid_lump","default:ice","default:dirt","Kvaveoxid lump","pollution_lump3.png","Vate bucket","pollution_nitrogenbucket.png","pollution:nbarrel"},
{"pollution:toxic_bucket","pollution:koloxid_lump","default:mese_crystal","default:clay","Koloxid lump","pollution_lump2.png","Toxic bucket","pollution_toxicbucket.png","pollution:barrel"},
{"pollution:vate_bucket","pollution:vate_lump","wool:red","default:gold_ingot","Vate lump","pollution_lump4.png","Nitrogen bucket","pollution_vatebucket.png","pollution:sbarrel 3"},
{"pollution:syra_bucket","pollution:syra_lump","default:diamond","default:gold_ingot","Syra lump","pollution_lump4.png^[colorize:#00ff00cc","Acid bucket","pollution_syra_bucket.png","pollution:ybarrel"}

}

for i = 1, #pollution_craft, 1 do

--Barrels

minetest.register_craft({
	output = pollution_craft[i][9],
	recipe = {
		{"default:steel_ingot", pollution_craft[i][1], "default:steel_ingot"},
		{"default:steel_ingot", pollution_craft[i][1], "default:steel_ingot"},
		{"default:steel_ingot", pollution_craft[i][1], "default:steel_ingot"},
	}
})

--Buckets

minetest.register_craft({
	output = pollution_craft[i][1],
	recipe = {
		{"default:steel_ingot", pollution_craft[i][2], "default:steel_ingot"},
		{"","default:steel_ingot",""},
	}
})

--lumps

minetest.register_craft({
	output = pollution_craft[i][2],
	recipe = {
		{"pollution:magnesium_lump", pollution_craft[i][3], "pollution:magnesium_ingot"},
		{"",pollution_craft[i][4],""},
	}
})


-- lump item

minetest.register_craftitem(pollution_craft[i][2], {
	description = pollution_craft[i][5],
	inventory_image = pollution_craft[i][6],
})

-- bucket item

minetest.register_craftitem(pollution_craft[i][1], {
	description = pollution_craft[i][7],
	inventory_image = pollution_craft[i][8],
})
end