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
	description = "Alien's Crystal",
--brower from glowtest mod,because it's not available in marssurvlve mod
	drawtype = "nodebox",
	tiles = {"marssurvive_crystal.png"},
     paramtype = "light",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 3,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,crystal=1},
	sounds = default.node_sound_glass_defaults(),
     node_box = {
        type = "fixed",
        fixed = {
            {-0.1875,-0.5,-0.125,0.1875,0.3125,0.1875},
            {0.0625,-0.5,-0.25,0.3125,0,0},
            {0.0625,-0.5,0.1875,0.25,0.1875,0.375},
            {-0.3125,-0.5,-0.3125,-0.0625,0.0625,0},
            {-0.375,-0.5,0.0625,-0.125,-0.0625,0.3125},
        }
    },
     on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("glowtest:blue_crystal_"..math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("glowtest:blue_crystal_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
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

minetest.register_tool("marssurvive:sandpick", {
	description = "Sandstone Pickaxe",
	inventory_image = "default_tool_woodpick.png^[colorize:#cf411b66",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=2.0, [3]=1.00}, uses=20, maxlevel=1},
			crumbly = {times={[1]=0.50, [2]=0.80, [3]=0.30}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
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
	marssurvive_replacenode({x=pos.x,y=pos.y+1,z=pos.z})
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
	marssurvive_replacenode({x=pos.x,y=pos.y-1,z=pos.z})
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
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y+1,z=pos.z})
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
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
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y-1,z=pos.z})
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y-1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	end,
})

minetest.register_node("marssurvive:door1_closed", {
	description = "Gate (does not support air)",
	drawtype = "mesh",
	mesh = "marssurvive_door1_closed.obj",
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-2.2, -0.5, -0.5, 3.2, 2.5, 0.5}

	},
collision_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 1.5, 2.5, 0.5},}},
	tiles = {"marssurvive_shieldblock.png","marssurvive_warntape.png","default_obsidian.png","default_obsidian.png","marssurvive_warntape.png","default_obsidian.png"},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	damage_per_second = 20,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		minetest.swap_node(pos, {name="marssurvive:door1", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door1", {pos=pos, gain = 1, max_hear_distance = 5})
	end,
})


minetest.register_node("marssurvive:door1", {
	description = "Gate (open)",
	drawtype = "mesh",
	mesh = "marssurvive_door1.obj",
	drop = "marssurvive:door1_closed",
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 1.5, 2.5, 0.5}
	},
collision_box = {
		type = "fixed",fixed = {
			{-3.4, -0.5, -0.5, -0.5, 2.5, 0.5},
			{4.4, -0.5, -0.5, 1.5, 2.5, 0.5}}},
	tiles = {"marssurvive_shieldblock.png","marssurvive_warntape.png","default_obsidian.png","default_obsidian.png","marssurvive_warntape.png","default_obsidian.png"},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.swap_node(pos, {name="marssurvive:door1_closed", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door1", {pos=pos, gain = 1, max_hear_distance = 5})
	end,
})


local nodes_g_s={
{"#cf411bff","small",0.25},
{"#cf411bff","medium",0.3},
}

for i = 1, #nodes_g_s, 1 do

minetest.register_node("marssurvive:stone_" .. nodes_g_s[i][2], {
	description = "Mars Stone " .. nodes_g_s[i][2],
	drawtype = "mesh",
	mesh = "stone1.obj",
	visual_scale = nodes_g_s[i][3],
	tiles = {"default_desert_stone.png^[colorize:#cf7d67ff"},
	groups = {dig_immediate=3,not_in_creative_inventory=0},
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
	tiles = {"marssurvive_oxogen^[colorize:#00ff00aa"},
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
	description = "Mars Sand",
	tiles = {"default_desert_sand.png^[colorize:#cf411b66"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("marssurvive:stone", {
	description = "Mars Stone",
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
	description = "Mars Cobblestone",
	tiles = {"default_desert_cobble.png^[colorize:#cf7d6788"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:ice", {
	description = "Mars Ice",
	tiles = {"default_ice.png^[colorize:#ffffff99"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, puts_out_fire = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("marssurvive:air2", {
	description = "Air (stabile)",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 20, r = 220, g = 200, b = 200},
	tiles = {"marssurvive_air.png^[colorize:#E0E0E033"},
	alpha = 0.1,
	groups = {msa=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
})

minetest.register_node("marssurvive:air", {
	description = "Air (unstabile)",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 180, r = 120, g = 120, b = 120},
	alpha = 20,
	tiles = {"marssurvive_air.png^[colorize:#E0E0E0CC"},
	groups = {msa=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(30)
	end,
	on_timer = function (pos, elapsed)
	minetest.set_node(pos, {name = "marssurvive:air2"})
	end
})

-- checks if the area is too big or if its outside in 14 directions
local airgen_tmpn=1
for i=0,5,1 do
if i==5 then airgen_tmpn=0 end
minetest.register_node("marssurvive:airgen" .. i, {
	description = "Air Generator " .. i*20 .."% power",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png","marssurvive_gen" .. i ..".png"},
	groups = {dig_immediate=3,not_in_creative_inventory=airgen_tmpn},
	sounds = default.node_sound_stone_defaults(),
on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Air Generator " .. i*20 .."% power")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if minetest.is_protected(pos,player:get_player_name())==false and minetest.get_node(pos).name~="marssurvive:airgen0" then
			local ch={xp=1,xm=1,yp=1,ym=1,zp=1,zm=1, ypxz=1,ypz=1,ypx=1,ypmxz=1, ymxz=1,ymz=1,ymx=1,ymmxz=1,all=14}
			for ii=1,marssurvive.air-2,1 do
				if ch.xp==1 and minetest.get_node({x=pos.x+ii,y=pos.y,z=pos.z}).name~="air" then ch.xp=0 ch.all=ch.all-1 end
				if ch.xm==1 and minetest.get_node({x=pos.x-ii,y=pos.y,z=pos.z}).name~="air" then ch.xm=0 ch.all=ch.all-1 end
				if ch.zp==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z+ii}).name~="air" then ch.zp=0 ch.all=ch.all-1 end
				if ch.zm==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z-ii}).name~="air" then ch.zm=0 ch.all=ch.all-1 end

				if ch.yp==1 and minetest.get_node({x=pos.x,y=pos.y+ii,z=pos.z}).name~="air" then ch.yp=0 ch.all=ch.all-1 end
				if ch.ym==1 and minetest.get_node({x=pos.x,y=pos.y-ii,z=pos.z}).name~="air" then ch.ym=0 ch.all=ch.all-1 end

				if ch.ypxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypxz=0 ch.all=ch.all-1 end
				if ch.ypz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypz=0 ch.all=ch.all-1 end
				if ch.ypx==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypx=0 ch.all=ch.all-1 end
				if ch.ypmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypmxz=0 ch.all=ch.all-1 end

				if ch.ymxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymxz=0 ch.all=ch.all-1 end
				if ch.ymz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymz=0 ch.all=ch.all-1 end
				if ch.ymx==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymx=0 ch.all=ch.all-1 end
				if ch.ymmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymmxz=0 ch.all=ch.all-1 end
				if ch.all==0 then break end
			end
				if ch.all>0 then
					minetest.get_meta(pos):set_string("infotext", "Air Generator " .. i*20 .."% power [This area is too big (max " .. marssurvive.air-1 .. ") you have to rebuild]")
					return
				end
			local done=0
			for ii=1,17,1 do
				minetest.get_meta(pos):set_int("prl",0)
				local np=minetest.find_node_near(pos,1,{"air"})
				if np~=nil then
					minetest.set_node(np, {name = "marssurvive:air"})
					minetest.get_meta(np):set_int("prl",1)
					done=1
				else
					break
				end
			end
			if done==1 then
				minetest.swap_node(pos, {name = "marssurvive:airgen" .. (i-1)})
				minetest.get_meta(pos):set_string("infotext", "Air Generator " .. (i-1)*20 .."% power")
				minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,})
			end
		end
	end,
})
end

minetest.register_node("marssurvive:airgen_public", {
	description = "Air Generator public",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png","marssurvive_gen_public.png"},
	groups = {dig_immediate=3,not_in_creative_inventory=airgen_tmpn},
	sounds = default.node_sound_stone_defaults(),
on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Air Generator public")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if true then
			local ch={xp=1,xm=1,yp=1,ym=1,zp=1,zm=1, ypxz=1,ypz=1,ypx=1,ypmxz=1, ymxz=1,ymz=1,ymx=1,ymmxz=1,all=14}
			for ii=1,marssurvive.air-2,1 do
				if ch.xp==1 and minetest.get_node({x=pos.x+ii,y=pos.y,z=pos.z}).name~="air" then ch.xp=0 ch.all=ch.all-1 end
				if ch.xm==1 and minetest.get_node({x=pos.x-ii,y=pos.y,z=pos.z}).name~="air" then ch.xm=0 ch.all=ch.all-1 end
				if ch.zp==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z+ii}).name~="air" then ch.zp=0 ch.all=ch.all-1 end
				if ch.zm==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z-ii}).name~="air" then ch.zm=0 ch.all=ch.all-1 end

				if ch.yp==1 and minetest.get_node({x=pos.x,y=pos.y+ii,z=pos.z}).name~="air" then ch.yp=0 ch.all=ch.all-1 end
				if ch.ym==1 and minetest.get_node({x=pos.x,y=pos.y-ii,z=pos.z}).name~="air" then ch.ym=0 ch.all=ch.all-1 end

				if ch.ypxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypxz=0 ch.all=ch.all-1 end
				if ch.ypz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypz=0 ch.all=ch.all-1 end
				if ch.ypx==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypx=0 ch.all=ch.all-1 end
				if ch.ypmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypmxz=0 ch.all=ch.all-1 end

				if ch.ymxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymxz=0 ch.all=ch.all-1 end
				if ch.ymz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymz=0 ch.all=ch.all-1 end
				if ch.ymx==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymx=0 ch.all=ch.all-1 end
				if ch.ymmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymmxz=0 ch.all=ch.all-1 end
				if ch.all==0 then break end
			end
				if ch.all>0 then
					minetest.get_meta(pos):set_string("infotext", "Air Generator public [This area is too big (max " .. marssurvive.air-1 .. ") you have to rebuild]")
					return
				end
			local done=0
			for ii=1,17,1 do
				minetest.get_meta(pos):set_int("prl",0)
				local np=minetest.find_node_near(pos,1,{"air"})
				if np~=nil then
					minetest.set_node(np, {name = "marssurvive:air"})
					minetest.get_meta(np):set_int("prl",1)
					done=1
				else
					break
				end
			end
			if done==1 then
--				minetest.swap_node(pos, {name = "marssurvive:airgen" .. (i-1)})
--				minetest.get_meta(pos):set_string("infotext", "Air Generator " .. (i-1)*20 .."% power")
				minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,})
			end
		end
	end,
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
	groups = {crumbly = 2, cracky = 3},
	drop = 'default:clay_lump',
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
		minetest.env:get_node_timer(pos):start(20)
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

minetest.register_node("marssurvive:air_gassbotte", {
	description = "Air gassbotte",
	tiles = {"default_steel_block.png"},
	--inventory_image = "default_steel_block.png",
	drawtype = "nodebox",
	groups = {dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	--paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.1,-0.5,-0.1,0.1,0.3,0.1}},
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

minetest.register_node("marssurvive:stone_with_iron1", {
	description = "Iron Ore(with Impurities)",
	tiles = {"default_desert_stone.png^default_mineral_iron1.png^[colorize:#cf7d6788"},
	groups = {cracky = 2},
	drop = 'default:iron_lump1',
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
	description = "Alien Big's material",
	tiles = {"marssurvive_unused.png"},
	inventory_image = "marssurvive_unused.png",
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:unused2", {
	description = "Alien Death's material",
	tiles = {"marssurvive_unused2.png"},
	inventory_image = "marssurvive_unused2.png",
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:unusedgold", {
	description = "Alien Small's gene",
	tiles = {"marssurvive_gold.png"},
	inventory_image = "marssurvive_gold.png",
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:ujeore", {
	description = "UjE ore (UjEdwin the creator of the mars mod)",
--	drop="default:steel_ingot 4",
	drop = {
		max_items = 4,
		items = {
			{items = {'default:steel_ingot'}, rarity = 2},
			{items = {'default:copper_lump'}, rarity = 2},
			{items = {'default:steel_ingot 2'}},
			{items = {'default:copper_lump'}}

		}
	},

	tiles = {"marssurvive_ujeore.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:airgen_unlimited", {
	description = "Unlimited Air Generator",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png","marssurvive_gen_public.png"},
	groups = {dig_immediate=3,not_in_creative_inventory=airgen_tmpn},
	sounds = default.node_sound_stone_defaults(),
on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Unlimited Air Generator")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if true then
			local ch={xp=1,xm=1,yp=1,ym=1,zp=1,zm=1, ypxz=1,ypz=1,ypx=1,ypmxz=1, ymxz=1,ymz=1,ymx=1,ymmxz=1,all=14}
			for ii=1,marssurvive.air-2,1 do
				if ch.xp==1 and minetest.get_node({x=pos.x+ii,y=pos.y,z=pos.z}).name~="air" then ch.xp=0 ch.all=ch.all-1 end
				if ch.xm==1 and minetest.get_node({x=pos.x-ii,y=pos.y,z=pos.z}).name~="air" then ch.xm=0 ch.all=ch.all-1 end
				if ch.zp==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z+ii}).name~="air" then ch.zp=0 ch.all=ch.all-1 end
				if ch.zm==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z-ii}).name~="air" then ch.zm=0 ch.all=ch.all-1 end

				if ch.yp==1 and minetest.get_node({x=pos.x,y=pos.y+ii,z=pos.z}).name~="air" then ch.yp=0 ch.all=ch.all-1 end
				if ch.ym==1 and minetest.get_node({x=pos.x,y=pos.y-ii,z=pos.z}).name~="air" then ch.ym=0 ch.all=ch.all-1 end

				if ch.ypxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypxz=0 ch.all=ch.all-1 end
				if ch.ypz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypz=0 ch.all=ch.all-1 end
				if ch.ypx==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypx=0 ch.all=ch.all-1 end
				if ch.ypmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypmxz=0 ch.all=ch.all-1 end

				if ch.ymxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymxz=0 ch.all=ch.all-1 end
				if ch.ymz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymz=0 ch.all=ch.all-1 end
				if ch.ymx==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymx=0 ch.all=ch.all-1 end
				if ch.ymmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymmxz=0 ch.all=ch.all-1 end
				if ch.all==0 then break end
			end
				if ch.all>0 then
					minetest.get_meta(pos):set_string("infotext", "Unlimited Air Generator [This area is too big (max " .. marssurvive.air-1 .. ") you have to rebuild]")
					return
				end
			local done=0
			for ii=1,17,1 do
				minetest.get_meta(pos):set_int("prl",0)
				local np=minetest.find_node_near(pos,1,{"air"})
				if np~=nil then
					minetest.set_node(np, {name = "marssurvive:air"})
					minetest.get_meta(np):set_int("prl",1)
					done=1
				else
					break
				end
			end
			if done==1 then
--				minetest.swap_node(pos, {name = "marssurvive:airgen" .. (i-1)})
--				minetest.get_meta(pos):set_string("infotext", "Air Generator " .. (i-1)*20 .."% power")
				minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,})
			end
		end
	end,
})

minetest.register_craftitem("marssurvive:batteryblock", {
	description = "Battery Block",
	inventory_image = "marssurvive_batteryblock.png",
})

minetest.register_craftitem("marssurvive:unlimitedbatteryblock", {
	description = "Unlimited Battery Block",
	inventory_image = "marssurvive_unlimitedbatteryblock.png",
})
