--\ Runes \

minetest.register_node("glowtest:rune_1", {
	description = "Wyvern Rune",
	tiles = {"default_stone.png^glowtest_rune_1.png"},
	is_ground_content = true,
    light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_1_off", {
	tiles = {"default_stone.png^glowtest_rune_1_off.png"},
	is_ground_content = true,
	groups = {cracky=3,not_in_creative_inventory=1},
     drop = "glowtest:rune_1",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_2", {
	description = "Eye Rune",
	tiles = {"default_stone.png^glowtest_rune_2.png"},
	is_ground_content = true,
    light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_2_off", {
	tiles = {"default_stone.png^glowtest_rune_2_off.png"},
	is_ground_content = true,
	groups = {cracky=3,not_in_creative_inventory=1},
     drop = "glowtest:rune_2",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_1_cursed", {
	description = "Cursed Wyvern Rune",
	tiles = {"default_stone.png^glowtest_rune_1_cursed.png"},
	is_ground_content = true,
    light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_1_cursed_off", {
	tiles = {"default_stone.png^glowtest_rune_1_off.png"},
	is_ground_content = true,
	groups = {cracky=3,not_in_creative_inventory=1},
     drop = "glowtest:rune_1_cursed",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_2_cursed", {
	description = "Cursed Eye Rune",
	tiles = {"default_stone.png^glowtest_rune_2_cursed.png"},
	is_ground_content = true,
    light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("glowtest:rune_2_cursed_off", {
	tiles = {"default_stone.png^glowtest_rune_2_off.png"},
	is_ground_content = true,
	groups = {cracky=3,not_in_creative_inventory=1},
     drop = "glowtest:rune_2_cursed",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1","glowtest:rune_2"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.env:get_objects_inside_radius(pos, 3)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()+2)
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1_cursed","glowtest:rune_2_cursed"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.env:get_objects_inside_radius(pos, 3)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-2)
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1_cursed"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_1_cursed_off"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1_cursed_off"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_1_cursed"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_2_cursed"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_2_cursed_off"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_2_cursed_off"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_2_cursed"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1_off"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_1_off"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_2_off"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_2"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"glowtest:rune_2"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="glowtest:rune_2_off"})
		end
	end,
})