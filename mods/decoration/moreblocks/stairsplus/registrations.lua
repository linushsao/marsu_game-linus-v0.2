--[[
More Blocks: registrations

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local default_nodes = { -- Default stairs/slabs/panels/microblocks:
	"stone",
	"cobble",
	"mossycobble",
	"brick",
	"sandstone",
	"steelblock",
	"goldblock",
	"copperblock",
	"bronzeblock",
	"diamondblock",
	"desert_stone",
	"desert_cobble",
	"meselamp",
	"glass",
	"tree",
	"wood",
	"jungletree",
	"junglewood",
	"pine_tree",
	"pine_wood",
	"acacia_tree",
	"acacia_wood",
	"aspen_tree",
	"aspen_wood",
	"obsidian",
	"obsidian_glass",
	"stonebrick",
	"desert_stonebrick",
	"sandstonebrick",
	"obsidianbrick",
}

for _, name in pairs(default_nodes) do
	local nodename = "default:" .. name
	local ndef = minetest.registered_nodes[nodename]
	if ndef then
		local drop
		if type(ndef.drop) == "string" then
			drop = ndef.drop:sub(9)
		end

		local tiles = ndef.tiles
		if #ndef.tiles > 1 and ndef.drawtype:find("glass") then
			tiles = { ndef.tiles[1] }
		end

		stairsplus:register_all("moreblocks", name, nodename, {
			description = ndef.description,
			drop = drop,
			groups = ndef.groups,
			sounds = ndef.sounds,
			tiles = tiles,
			sunlight_propagates = true,
			light_source = ndef.light_source
		})
	end
end
-- Adding some SciFi nodes to circular saw

stairsplus:register_all("scifi_nodes", "white2", "scifi_nodes:white2", {
    description = "SciFi plastic",
	tiles = {"scifi_nodes_white2.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "white", "scifi_nodes:white", {
    description = "SciFi plastic wall",
	tiles = {"scifi_nodes_white.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "tile", "scifi_nodes:tile", {
    description = "SciFi white tile",
	tiles = {"scifi_nodes_tile.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "whitetile", "scifi_nodes:whitetile", {
    description = "SciFi white tile2",
	tiles = {"scifi_nodes_whitetile.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "whtlightbnd", "scifi_nodes:whtlightbnd", {
    description = "SciFi white light stripe",
	tiles = {"scifi_nodes_lightband.png"},
	groups = {cracky=1},
    light_source = 10,
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blklt2", "scifi_nodes:blklt2", {
    description = "SciFi black stripe light",
	tiles = {"scifi_nodes_black_light2.png"},
	groups = {cracky=1},
    light_source = 10,
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "doomlight", "scifi_nodes:doomlight", {
    description = "SciFi Doom light",
	tiles = {"scifi_nodes_doomlight.png"},
	groups = {cracky=1},
    light_source = 12,
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "ppllght", "scifi_nodes:ppllght", {
    description = "SciFi purple wall light",
	tiles = {"scifi_nodes_ppllght.png"},
	groups = {cracky=1},
    light_source = LIGHT_MAX,
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "rust", "scifi_nodes:rust", {
    description = "SciFi rusty metal ",
	tiles = {"scifi_nodes_rust.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "red_square", "scifi_nodes:red_square", {
    description = "SciFi red metal block ",
	tiles = {"scifi_nodes_red_square.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "purple", "scifi_nodes:purple", {
    description = "SciFi purple",
	tiles = {"scifi_nodes_purple.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "pplblk", "scifi_nodes:pplblk", {
    description = "SciFi purple tile",
	tiles = {"scifi_nodes_pplblk.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "bluemetal", "scifi_nodes:bluemetal", {
    description = "SciFi blue",
	tiles = {"scifi_nodes_bluemetal.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "bluebars", "scifi_nodes:bluebars", {
    description = "SciFi blue bars",
	tiles = {"scifi_nodes_bluebars.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blue_square", "scifi_nodes:blue_square", {
    description = "SciFi blue metal block ",
	tiles = {"scifi_nodes_blue_square.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "grey", "scifi_nodes:grey", {
    description = "SciFi grey",
	tiles = {"scifi_nodes_grey.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "greybars", "scifi_nodes:greybars", {
    description = "SciFi grey bars",
	tiles = {"scifi_nodes_greybars.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "grey_square", "scifi_nodes:grey_square", {
    description = "SciFi grey metal block ",
	tiles = {"scifi_nodes_grey_square.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "greytile", "scifi_nodes:greytile", {
    description = "SciFi grey tile",
	tiles = {"scifi_nodes_greytile.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "wall", "scifi_nodes:wall", {
    description = "SciFi metal wall",
	tiles = {"scifi_nodes_wall.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "mesh", "scifi_nodes:mesh", {
    description = "SciFi metal mesh",
	tiles = {"scifi_nodes_mesh.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "vent2", "scifi_nodes:vent2", {
    description = "SciFi vent",
	tiles = {"scifi_nodes_vent2.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "rough", "scifi_nodes:rough", {
    description = "SciFi rough metal",
	tiles = {"scifi_nodes_rough.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "lighttop", "scifi_nodes:lighttop", {
    description = "SciFi metal block",
	tiles = {"scifi_nodes_lighttop.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "black", "scifi_nodes:black", {
    description = "SciFi black",
	tiles = {"scifi_nodes_black.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blacktile", "scifi_nodes:blacktile", {
    description = "SciFi black tile",
	tiles = {"scifi_nodes_blacktile.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blackplate", "scifi_nodes:blackplate", {
    description = "SciFi black plate",
	tiles = {"scifi_nodes_blackplate.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blacktile2", "scifi_nodes:blacktile2", {
    description = "SciFi black tile 2",
	tiles = {"scifi_nodes_blacktile2.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "blackvent", "scifi_nodes:blackvent", {
    description = "SciFi black vent",
	tiles = {"scifi_nodes_blackvent.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "greenmetal", "scifi_nodes:greenmetal", {
    description = "SciFi green",
	tiles = {"scifi_nodes_greenmetal.png"},
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "green_square", "scifi_nodes:green_square", {
    description = "SciFi green metal block ",
	tiles = {"scifi_nodes_green_square.png"},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

stairsplus:register_all("scifi_nodes", "greenlights2", "scifi_nodes:greenlights2", {
    description = "SciFi green lights 2",
	tiles = {"scifi_nodes_greenlights2.png"},
	groups = {cracky=1},
    light_source = 10,
	sounds = default.node_sound_defaults(),
})

stairsplus:register_all("scifi_nodes", "greenbar", "scifi_nodes:greenbar", {
    description = "SciFi green light bar",
	tiles = {"scifi_nodes_greenbar.png"},
	groups = {cracky=1},
    light_source = 10,
	sounds = default.node_sound_defaults(),
})
