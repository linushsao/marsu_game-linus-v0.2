
local groups = {choppy=2, dig_immediate=3, picture=1, not_in_creative_inventory=1}

--PrayForSyrian.jpg
minetest.register_node("gemalde:node_PrayForSyrian", {
	description = "PrayForSyrian",
	drawtype = "signlike",
	tiles = {"PrayForSyrian.jpg"},
	visual_scale = 3.0,
	inventory_image = "gemalde_node.png",
	wield_image = "gemalde_node.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = groups,

})

--OnMars.jpg
minetest.register_node("gemalde:node_OnMars", {
	description = "LOTR map",
	drawtype = "signlike",
	tiles = {"OnMars.jpg"},
	visual_scale = 3.0,
	inventory_image = "gemalde_node.png",
	wield_image = "gemalde_node.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = groups,

})
