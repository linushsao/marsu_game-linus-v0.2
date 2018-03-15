moretrees.avoidnodes = {}

moretrees.treelist = {
	{"beech",	"Beech Tree"},
	{"apple_tree",	"Apple Tree"},
	{"oak",		"Oak Tree",		"acorn",	"Acorn",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"sequoia",	"Giant Sequoia"},
	{"birch",	"Birch Tree"},
	{"palm",	"Palm Tree",		"coconut",	"Coconut",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 1.0 },
	{"spruce",	"Spruce Tree",		"spruce_cone",	"Spruce Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"pine",	"Pine Tree",		"pine_cone",	"Pine Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
	{"willow",	"Willow Tree"},
	{"rubber_tree",	"Rubber Tree"},
	{"jungletree",	"Jungle Tree"},
	{"fir",		"Douglas Fir",		"fir_cone",	"Fir Cone",	{-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}

local dirs1 = { 21, 20, 23, 22, 21 }
local dirs2 = { 12, 9, 18, 7, 12 }
local dirs3 = { 14, 11, 16, 5, 14 }

local moretrees_new_leaves_drawtype = "allfaces_optional"
local moretrees_new_leaves_extension = ".png"
local moretrees_plantlike_leaves_visual_scale = 1

if moretrees.plantlike_leaves then
	moretrees_new_leaves_drawtype = "plantlike"
	moretrees_new_leaves_extension = "_plantlike.png"
	moretrees_plantlike_leaves_visual_scale = 1.189
end

local new_default_leaves = moretrees:clone_node("default:leaves")
	if moretrees.enable_default_leafdecay then
		new_default_leaves.groups = {snappy=3, flammable=2, leaves=1}
	end
	if moretrees.plantlike_leaves then
		new_default_leaves.inventory_image = minetest.inventorycube("default_leaves.png")
		new_default_leaves.drawtype = "plantlike"
		new_default_leaves.visual_scale = moretrees_plantlike_leaves_visual_scale
		new_default_leaves.tiles = {"default_leaves_plantlike.png"}
	else
		new_default_leaves.waving = 1
	end
	if moretrees.enable_default_leafdecay or moretrees.plantlike_leaves then
		minetest.register_node(":default:leaves", new_default_leaves)
	end

local new_default_jungleleaves = moretrees:clone_node("default:jungleleaves")
	if moretrees.enable_default_leafdecay then
		new_default_jungleleaves.groups = {snappy=3, flammable=2, leaves=1}
	end
	if moretrees.plantlike_leaves then
		new_default_jungleleaves.inventory_image = minetest.inventorycube("default_jungleleaves.png")
		new_default_jungleleaves.drawtype = "plantlike"
		new_default_jungleleaves.visual_scale = moretrees_plantlike_leaves_visual_scale
		new_default_jungleleaves.tiles = {"default_jungleleaves_plantlike.png"}
	else
		new_default_jungleleaves.waving = 1
	end
	if moretrees.enable_default_leafdecay or moretrees.plantlike_leaves then
		minetest.register_node(":default:jungleleaves", new_default_jungleleaves)
	end

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]
	local treedesc = moretrees.treelist[i][2]
	local fruit = moretrees.treelist[i][3]
	local fruitdesc = moretrees.treelist[i][4]
	local selbox = moretrees.treelist[i][5]
	local vscale = moretrees.treelist[i][6]

	if treename ~= "jungletree" then -- the default game provides jungle tree trunk/planks nodes.

		minetest.register_node("moretrees:"..treename.."_trunk", {
			description = treedesc.." Trunk",
			tiles = {
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk_top.png",
				"moretrees_"..treename.."_trunk.png"
			},
			paramtype2 = "facedir",
			is_ground_content = true,
			groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
			sounds = default.node_sound_wood_defaults(),
			on_place = minetest.rotate_node,
		})
		--linus added
		minetest.register_craft({
			type = "fuel",
			recipe = "moretrees:"..treename.."_trunk",
			burntime = 15,
		})

		minetest.register_node("moretrees:"..treename.."_planks", {
			description = treedesc.." Planks",
			tiles = {"moretrees_"..treename.."_wood.png"},
			is_ground_content = true,
			groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
			sounds = default.node_sound_wood_defaults(),
		})

		--linus added
		local battery_material={"moreores:silver_ingot","technic:lead_ingot","technic:sulfur_electrode"}
			for _,v in ipairs(battery_material) do
			minetest.register_craft({
				output = 'technic:battery',
				recipe = {
					{"moretrees:"..treename.."_planks", v, "moretrees:"..treename.."_planks"},
					{"moretrees:"..treename.."_planks", 'moreores:tin_ingot', "moretrees:"..treename.."_planks"},
					{"moretrees:"..treename.."_planks", v, "moretrees:"..treename.."_planks"},
					}
				})
			end
			local v = "moretrees:"..treename.."_planks"
			minetest.register_craft({
				output = 'default:chest',
				recipe = {
					{v, v, v},
					{v, '',v},
					{v, v, v},
				}
			})
			minetest.register_craft({
				output = 'default:chest_locked',
				recipe = {
					{v, v, v},
					{v, 'default:steel_ingot', v},
					{v, v, v},
				}
			})
			--<<

		minetest.register_node("moretrees:"..treename.."_sapling", {
			description = treedesc.." Sapling",
			drawtype = "plantlike",
			tiles = {"moretrees_"..treename.."_sapling.png"},
			inventory_image = "moretrees_"..treename.."_sapling.png",
			paramtype = "light",
			paramtype2 = "waving",
			walkable = false,
			selection_box = {
				type = "fixed",
				fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
			},
			groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,sapling=1},
			sounds = default.node_sound_defaults(),
		})

		minetest.register_node("moretrees:"..treename.."_sapling_ongen", {
			description = treedesc.." Sapling",
			drawtype = "plantlike",
			tiles = {"moretrees_"..treename.."_sapling.png"},
			inventory_image = "moretrees_"..treename.."_sapling.png",
			paramtype = "light",
			paramtype2 = "waving",
			walkable = false,
			selection_box = {
				type = "fixed",
				fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
			},
			groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,not_in_creative_inventory=1,sapling=1},
			sounds = default.node_sound_defaults(),
			drop = "moretrees:"..treename.."_sapling"
		})

		-- player will get a sapling with 1/100 chance
		-- player will get leaves only if he/she gets no saplings,
		-- this is because max_items is 1


		local droprarity = 100

		if treename == "palm" then
			droprarity = 20
		end

		local moretrees_leaves_inventory_image = nil
		local moretrees_new_leaves_waving = nil

		if moretrees.plantlike_leaves then
			moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_"..treename.."_leaves.png")
		else
			moretrees_new_leaves_waving = 1
		end

		minetest.register_node("moretrees:"..treename.."_leaves", {
			description = treedesc.." Leaves",
			drawtype = moretrees_new_leaves_drawtype,
			waving = moretrees_new_leaves_waving,
			visual_scale = moretrees_plantlike_leaves_visual_scale,
			tiles = { "moretrees_"..treename.."_leaves"..moretrees_new_leaves_extension },
			inventory_image = moretrees_leaves_inventory_image,
			paramtype = "light",
			groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1},
			sounds = default.node_sound_leaves_defaults(),

			drop = {
				max_items = 1,
				items = {
					{items = {"moretrees:"..treename.."_sapling"}, rarity = droprarity },
					{items = {"moretrees:"..treename.."_leaves"} }
				}
			},
		})

		--linus added
		minetest.register_craft({
			type = "fuel",
			recipe = "moretrees:"..treename.."_leaves",
			burntime = 2,
		})

		if minetest.get_modpath("moreblocks") and moretrees.enable_stairsplus then

			register_stair(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_stair=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_slab(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_slab=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_panel(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_panel=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_micro(
				"moretrees",
				treename.."_trunk",
				"moretrees:"..treename.."_trunk",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1, tree_micro=1 },
				{	"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk_top.png",
					"moretrees_"..treename.."_trunk.png"
				},
				treedesc.." Trunk",
				treename.."_trunk",
				0
			)

			register_stair(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_stair=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_slab(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_slab=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_panel(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_panel=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)

			register_micro(
				"moretrees",
				treename.."_planks",
				"moretrees:"..treename.."_planks",
				{ snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1, wood_micro=1 },
				{ "moretrees_"..treename.."_wood.png" },
				treedesc.." Planks",
				treename.."_planks",
				0
			)


			table.insert(circular_saw.known_stairs, "moretrees:"..treename.."_trunk")
			table.insert(circular_saw.known_stairs, "moretrees:"..treename.."_planks")
		end
	end

	if fruit then
		minetest.register_node("moretrees:"..fruit, {
			description = fruitdesc,
			drawtype = "plantlike",
			tiles = { "moretrees_"..fruit..".png" },
			inventory_image = "moretrees_"..fruit..".png^[transformR180",
			wield_image = "moretrees_"..fruit..".png^[transformR180",
			visual_scale = vscale,
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			selection_box = {
				type = "fixed",
					fixed = selbox
				},
			groups = {fleshy=3,dig_immediate=3,flammable=2, attached_node=1},
			sounds = default.node_sound_defaults(),
		})
	end

	minetest.register_abm({
		nodenames = { "moretrees:"..treename.."_trunk_sideways" },
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local fdir = node.param2 or 0
				nfdir = dirs2[fdir+1]
			minetest.add_node(pos, {name = "moretrees:"..treename.."_trunk", param2 = nfdir})
		end,
	})

	table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_trunk")

	if moretrees.spawn_saplings then
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling")
			table.insert(moretrees.avoidnodes, "moretrees:"..treename.."_sapling_ongen")
	end
end

-- Extra nodes for jungle trees:

minetest.register_node("moretrees:jungletree_sapling", {
        description = "Jungle Sapling",
        drawtype = "plantlike",
        visual_scale = 1.0,
        tiles = {"default_junglesapling.png"},
        inventory_image = "default_junglesapling.png",
        wield_image = "default_junglesapling.png",
        paramtype = "light",
		paramtype2 = "waving",
        walkable = false,
        selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
        },
        groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,sapling=1},
        sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moretrees:jungletree_sapling_ongen", {
        description = "Jungle Sapling",
        drawtype = "plantlike",
        visual_scale = 1.0,
        tiles = {"default_junglesapling.png"},
        inventory_image = "default_junglesapling.png",
        wield_image = "default_junglesapling.png",
        paramtype = "light",
		paramtype2 = "waving",
        walkable = false,
        selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
        },
        groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1,not_in_creative_inventory=1,sapling=1},
        sounds = default.node_sound_leaves_defaults(),
	drop = "moretrees:jungletree_sapling"
})

local jungleleaves = {"green","yellow","red"}
local jungleleavesnames = {"Green", "Yellow", "Red"}
for color = 1, 3 do
	local leave_name = "moretrees:jungletree_leaves_"..jungleleaves[color]

	local moretrees_leaves_inventory_image = nil

	if moretrees.plantlike_leaves then
		moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_jungletree_leaves_"..jungleleaves[color]..".png")
	else
		moretrees_new_leaves_waving = 1
	end

	minetest.register_node(leave_name, {
		description = "Jungle Tree Leaves ("..jungleleavesnames[color]..")",
		drawtype = moretrees_new_leaves_drawtype,
		waving = moretrees_new_leaves_waving,
		visual_scale = moretrees_plantlike_leaves_visual_scale,
		tiles = {"moretrees_jungletree_leaves_"..jungleleaves[color]..moretrees_new_leaves_extension},
		inventory_image = moretrees_leaves_inventory_image,
		paramtype = "light",
		groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1},
		drop = {
			max_items = 1,
			items = {
				{items = {'moretrees:jungletree_sapling'}, rarity = 100 },
				{items = {"moretrees:jungletree_leaves_"..jungleleaves[color]} }
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

-- Extra needles for firs

local moretrees_leaves_inventory_image = nil

if moretrees.plantlike_leaves then
	moretrees_leaves_inventory_image = minetest.inventorycube("moretrees_fir_leaves_bright.png")
end

minetest.register_node("moretrees:fir_leaves_bright", {
	drawtype = moretrees_new_leaves_drawtype,
	waving = moretrees_new_leaves_waving,
	visual_scale = moretrees_plantlike_leaves_visual_scale,
	description = "Douglas Fir Leaves (Bright)",
	tiles = { "moretrees_fir_leaves_bright"..moretrees_new_leaves_extension },
	inventory_image = moretrees_leaves_inventory_image,
	paramtype = "light",
	groups = {snappy=3, flammable=2, leaves=1, moretrees_leaves=1 },
	drop = {
		max_items = 1,
		items = {
			{items = {'moretrees:fir_sapling'}, rarity = 100 },
			{items = {'moretrees:fir_leaves'} }
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

if moretrees.enable_redefine_apple then
	local new_default_apple = moretrees:clone_node("default:apple")
		new_default_apple.groups.attached_node = 1
	minetest.register_node(":default:apple", new_default_apple)
end

table.insert(moretrees.avoidnodes, "default:jungletree")
table.insert(moretrees.avoidnodes, "moretrees:jungletree_trunk")
table.insert(moretrees.avoidnodes, "moretrees:fir_trunk")
table.insert(moretrees.avoidnodes, "default:tree")

if moretrees.spawn_saplings then
		table.insert(moretrees.avoidnodes, "snow:sapling_pine")
		table.insert(moretrees.avoidnodes, "default:junglesapling")
		table.insert(moretrees.avoidnodes, "moretrees:jungle_tree_sapling")
		table.insert(moretrees.avoidnodes, "moretrees:jungle_tree_sapling_ongen")
end

-- "empty" (tapped) rubber tree nodes

minetest.register_node("moretrees:rubber_tree_trunk_empty", {
	description = "Rubber Tree Trunk (Empty)",
	tiles = {
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_top.png",
		"moretrees_rubber_tree_trunk_empty.png"
	},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	after_place_node = function(pos, placer, itemstack)
 			local meta = minetest.get_meta(pos)
			meta:set_int("placed", 1)
	end
})

minetest.register_abm({
	nodenames = { "moretrees:rubber_tree_trunk_empty_sideways" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "moretrees:rubber_tree_trunk_empty", param2 = nfdir})
	end,
})

-- For compatibility with old nodes and recently-changed nodes.

minetest.register_alias("technic:rubber_tree_full",      "moretrees:rubber_tree_trunk")
minetest.register_alias("farming_plus:rubber_tree_full", "moretrees:rubber_tree_trunk")

minetest.register_alias("technic:rubber_leaves",      "moretrees:rubber_tree_leaves")
minetest.register_alias("farming_plus:rubber_leaves", "moretrees:rubber_tree_leaves")

minetest.register_alias("farming_plus:rubber_sapling", "moretrees:rubber_tree_sapling")
minetest.register_alias("technic:rubber_tree_sapling", "moretrees:rubber_tree_sapling")

minetest.register_alias("default:junglesapling","moretrees:jungletree_sapling")
minetest.register_alias("moretrees:jungletree_trunk_sideways", "moreblocks:horizontal_jungle_tree")

minetest.register_alias("jungletree:leaves_green", "moretrees:jungletree_leaves_green")
minetest.register_alias("jungletree:leaves_red", "moretrees:jungletree_leaves_red")
minetest.register_alias("jungletree:leaves_yellow", "moretrees:jungletree_leaves_yellow")

minetest.register_alias("moretrees:conifer_trunk", "moretrees:fir_trunk")
minetest.register_alias("moretrees:conifer_trunk_sideways", "moretrees:fir_trunk_sideways")
minetest.register_alias("moretrees:conifer_leaves", "moretrees:fir_leaves")
minetest.register_alias("moretrees:conifer_leaves_bright", "moretrees:fir_leaves_bright")
minetest.register_alias("moretrees:conifer_sapling", "moretrees:fir_sapling")

minetest.register_alias("conifers:trunk", "moretrees:fir_trunk")
minetest.register_alias("conifers:trunk_reversed", "moretrees:fir_trunk_sideways")
minetest.register_alias("conifers:leaves", "moretrees:fir_leaves")
minetest.register_alias("conifers:leaves_special", "moretrees:fir_leaves_bright")
minetest.register_alias("conifers:sapling", "moretrees:fir_sapling")
