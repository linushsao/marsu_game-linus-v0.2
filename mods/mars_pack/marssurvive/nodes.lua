minetest.register_node("marssurvive:trapdoor_1", {
	description = "Trap door",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.375, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, 0.4375, -0.5, 0.5, 0.375, 0.5},
		}
	},
	tiles = {"marssurvive_shieldblock.png","marssurvive_shieldblock.png","marssurvive_door2.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_door2_2.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	climbable = true,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.swap_node(pos, {name="marssurvive:trapdoor_2", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.after(4, function(pos)
		if minetest.get_node(pos).name=="marssurvive:trapdoor_2" then
			minetest.swap_node(pos, {name="marssurvive:trapdoor_1", param2=minetest.get_node(pos).param2})
			minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
		end
	end, pos)


	end,
})
minetest.register_node("marssurvive:trapdoor_2", {
	description = "Trap door (open)",
	drop="marssurvive:trapdoor_1",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.375, -0.5, 1.5, -0.4375, 0.5},
			{0.375, 0.4375, -0.5, 1.5, 0.375, 0.5},
		}
	},
	tiles = {"marssurvive_shieldblock.png","marssurvive_shieldblock.png","marssurvive_door2_open.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_door2_2_open.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	climbable = true,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(pos, {name="marssurvive:trapdoor_1", param2=minetest.get_node(pos).param2})
	end,
})


minetest.register_node("marssurvive:smart_glasspane_side", {
	description = "Smart glass pane (sides)",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	wield_image = "default_glass.png",
	drawtype = "nodebox",
	groups = {cracky = 2, oddly_breakable_by_hand = 3},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
		}
	},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("marssurvive:smart_glasspane_down", {
	description = "Smart glass pane (down)",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	wield_image = "default_glass.png",
	drawtype = "nodebox",
	groups = {cracky = 2, oddly_breakable_by_hand = 3,not_in_creative_inventory=1},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		}
	},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("marssurvive:smart_glasspane_up", {
	description = "Smart glass pane (up)",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	wield_image = "default_glass.png",
	drawtype = "nodebox",
	groups = {cracky = 2, oddly_breakable_by_hand = 3,not_in_creative_inventory=1},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		}
	},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
})



minetest.register_node("marssurvive:crystal", {
	description = "Crystal",
	drawtype = "mesh",
	mesh = "marssurvive_crystal.obj",
	visual_scale = 0.16,
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {
		{
			name = "marssurvive_glitsh.png^[colorize:#cc0000aa",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	damage_per_second = 4,
	is_ground_content = false,
	light_source=4,
	groups = {cracky = 2, level = 2,not_in_creative_inventory=0},
})



minetest.register_node("marssurvive:clight", {
	description = "Ceiling light",
	tiles = {"default_cloud.png"},
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=0},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",fixed={-0.2,0.4,-0.4,0.2,0.6,0.4}},
	light_source=14,
})

minetest.register_node("marssurvive:tospaceteleporter", {
	description = "To space teleporter (to get more, type: /giveme marssurvive:tospaceteleporter 99)",
	tiles = {"marssurvive_shieldblock.png^marssurvive_oxogen.png"},
	groups = {cracky = 1, not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX - 1,
	sounds = default.node_sound_stone_defaults(),
	drawtype="nodebox",
	node_box = {
	type="fixed",
	fixed={-0.5,-0.5,-0.5,0.5,-0.4,0.5}},


after_place_node = function(pos, placer, itemstack, pointed_thing)
		local pos2={x=pos.x,y=1100,z=pos.z}
		local name=placer:get_player_name()
		minetest.get_meta(pos):set_string("owner", name)
		if pos.y<1000 and minetest.is_protected(pos2,name)==false then
			minetest.get_meta(pos):set_string("infotext", "To space teleporter (" .. name ..")")
			minetest.get_meta(pos):set_int("pos", 1)
			placer:moveto({x=pos.x,y=1111,z=pos.z})
				minetest.after(0.3, function(pos,pos2,name,placer)
				minetest.set_node(pos2, {name = "marssurvive:tospaceteleporter"})
				minetest.get_meta(pos2):set_string("infotext", "To mars teleporter (" .. name ..")")
				minetest.get_meta(pos2):set_string("owner", name)
				minetest.get_meta(pos2):set_int("pos", 2)
				minetest.get_meta(pos2):set_int("posy", pos.y+1)
				placer:moveto({x=pos.x,y=pos.y+1,z=pos.z})
			end,pos,pos2,name,placer)
		elseif pos.y>=1000 then
			minetest.get_meta(pos):set_string("infotext", "To space teleporte: this should only be used on mars")
		else
			minetest.get_meta(pos):set_string("infotext", "To space teleporter: you cant use this position (protected)")
		end
		end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			local meta=minetest.get_meta(pos)
			if meta:get_int("pos")==1 then
				player:moveto({x=pos.x,y=1101,z=pos.z})
				marssurvive_space(player)
			else
				player:moveto({x=pos.x,y=meta:get_int("posy"),z=pos.z})
				marssurvive_space(player)
			end
		end,
can_dig = function(pos, player)
		return player:get_player_name()==minetest.get_meta(pos):get_string("owner")
		end,
})


minetest.register_node("marssurvive:door2_1", {
	description = "Door",
	drop="marssurvive:door2_1",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_door2_2.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
after_place_node = function(pos, placer, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	if minetest.registered_nodes[minetest.get_node(p).name].walkable then
		return false
	else
		minetest.set_node(p, {name = "marssurvive:door2_2",param2=minetest.get_node(pos).param2})
	end
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.swap_node(p, {name="marssurvive:door2_open_2", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_open_1", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.after(2, function(pos,p)
		if minetest.get_node(pos).name=="marssurvive:door2_open_1" then
			minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
			minetest.swap_node(p, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
			minetest.swap_node(pos, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
		end
	end, pos,p)
	end,
	after_dig_node = function (pos, name, digger)
		marssurvive.replacenode({x=pos.x,y=pos.y+1,z=pos.z})
	end,
})

minetest.register_node("marssurvive:door2_2", {
	description = "Door 2-1",
	drawtype = "nodebox",
	drop="marssurvive:door2_1",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_door2_2.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y-1,z=pos.z}
	minetest.swap_node(p, {name="marssurvive:door2_open_1", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_open_2", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.after(2, function(pos,p)
		if minetest.get_node(pos).name=="marssurvive:door2_open_2" then
			minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
			minetest.swap_node(p, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
			minetest.swap_node(pos, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
		end
	end, pos,p)
	end,
	after_dig_node = function (pos, name, digger)
		marssurvive.replacenode({x=pos.x,y=pos.y-1,z=pos.z})
	end,
})

minetest.register_node("marssurvive:door2_open_1", {
	description = "Door (open) 2-o-1",
	drop="marssurvive:door2_1",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.41, -0.5, -0.124, 1.41, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_door2_2_open.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
	end,
	after_dig_node = function (pos, name, digger)
		marssurvive.replacenode({x=pos.x,y=pos.y+1,z=pos.z})
	end,
})

minetest.register_node("marssurvive:door2_open_2", {
	description = "Door (open) 2-o-1",
	drawtype = "nodebox",
	drop="marssurvive:door2_1",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.41, -0.5, -0.124, 1.41, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_door2_2_open.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y-1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	end,
	after_dig_node = function (pos, name, digger)
		marssurvive.replacenode({x=pos.x,y=pos.y-1,z=pos.z})
	end,
})

local nodes_g_s={
{"#cf411bff","small",0.25},
{"#cf411bff","medium",0.3},
}

for i = 1, #nodes_g_s, 1 do

minetest.register_node("marssurvive:stone_" .. nodes_g_s[i][2], {
	description = "Stone " .. nodes_g_s[i][2],
	drawtype = "mesh",
	mesh = "stone1.obj",
	visual_scale = nodes_g_s[i][3],
	tiles = {"default_desert_stone.png^[colorize:#cf7d67ff"},
	groups = {dig_immediate=3,not_in_creative_inventory=0,stone=1},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.-0.25, 0.3}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.3, -0.5, -0.3, 0.3, 0.-0.25, 0.3},}},
})
end

minetest.register_node("marssurvive:stone_glow", {
	description = "Stone glow",
	drawtype = "mesh",
	mesh = "stone1.obj",
	visual_scale = 0.27,
	tiles = {"marssurvive_oxogen.png^[colorize:#00ff00aa"},
	groups = {dig_immediate=3,not_in_creative_inventory=0,stone=1},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	is_ground_content = false,
	light_source=3,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.-0.25, 0.3}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.3, -0.5, -0.3, 0.3, 0.-0.25, 0.3},}},
})

minetest.register_node("marssurvive:sand", {
	description = "Sand",
	tiles = {"default_desert_sand.png^[colorize:#cf411b66"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("marssurvive:stone", {
	description = "Stone",
	tiles = {"default_desert_stone.png^[colorize:#cf7d6788"},
	groups = {cracky = 3, stone = 1},
	drop = 'marssurvive:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:warning", {
	description = "Warning tape block",
	tiles = {"marssurvive_warntape.png"},
	groups = {cracky = 2,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:glitch", {
	description = "glitch",
	tiles = {"marssurvive_glitsh.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("marssurvive:cobble", {
	description = "Cobblestone",
	tiles = {"default_desert_cobble.png^[colorize:#cf7d6788"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:ice", {
	description = "Ice",
	tiles = {"default_ice.png^[colorize:#ffffff99"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("marssurvive:shieldblock", {
	description = "Shieldblock",
	tiles = {"marssurvive_shieldblock.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:steelwallblock", {
	description = "Steel wallblock",
	tiles = {"marssurvive_wall.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:clayblock", {
	description = "Clayblock",
	tiles = {"default_clay.png^[colorize:#863710aa"},
	groups = {crumbly = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:oxogen", {
	description = "Oxygen block",
	tiles = {"marssurvive_oxogen.png"},
	drawtype="glasslike",
	groups = {crumbly = 2},
	paramtype = "light",
	sunlight_propagates = true,
	alpha = 50,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("marssurvive:mars_sapling", {
	description = "Mars sapling",
	tiles = {"default_sapling.png^[colorize:#86371055"},
	drawtype="plantlike",
	paramtype = "light",
	walkable=false,
	sunlight_propagates = true,
	groups = {crumbly = 3,},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(20)
	end,
	on_timer = function (pos, elapsed)
		if math.random(5)==1 then
			minetest.set_node(pos, {name = "marssurvive:tree"})
			local tree=minetest.get_modpath("marssurvive").."/schems/mars_tree.mts"
			minetest.place_schematic({x=pos.x-3,y=pos.y,z=pos.z-3}, tree, "random", {}, false)
		return false
		end
	return true
	end,
})

minetest.register_node("marssurvive:wood", {
	description = "Mars wood",
	tiles = {"default_junglewood.png^[colorize:#86371055"},
	groups = {crumbly = 2,wood=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("marssurvive:tree", {
	description = "Mars tree",
	tiles = {"default_tree.png^[colorize:#86371055"},
	groups = {crumbly = 2,tree=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_desert_stone.png^default_mineral_coal.png^[colorize:#cf7d6788"},
	groups = {cracky = 3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_desert_stone.png^default_mineral_iron.png^[colorize:#cf7d6788"},
	groups = {cracky = 2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("marssurvive:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_desert_stone.png^default_mineral_copper.png^[colorize:#cf7d6788"},
	groups = {cracky = 2},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:stone_with_mese", {
	description = "Mese Ore",
	tiles = {"default_desert_stone.png^default_mineral_mese.png^[colorize:#cf7d6788"},
	groups = {cracky = 1},
	drop = "default:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:stone_with_gold", {
	description = "Gold Ore",
	tiles = {"default_desert_stone.png^default_mineral_gold.png^[colorize:#cf7d6788"},
	groups = {cracky = 2},
	drop = "default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:stone_with_diamond", {
	description = "Diamond Ore",
	tiles = {"default_desert_stone.png^default_mineral_diamond.png^[colorize:#cf7d6788"},
	groups = {cracky = 1},
	drop = "default:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:unused", {
	description = "Unused",
	tiles = {"marssurvive_unused.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:unused2", {
	description = "Unused 2",
	tiles = {"marssurvive_unused2.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:unusedgold", {
	description = "Unused gold",
	tiles = {"marssurvive_gold.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:ujeore", {
	description = "ATE ore (AiTechEye the creator of the mars mod)",
	drop="default:iron_lump 6",
	tiles = {"marssurvive_ateore.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:cloud", {
	description = "Cloud",
	tiles = {"default_cloud.png"},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
	--drawtype = "airlike",
})

