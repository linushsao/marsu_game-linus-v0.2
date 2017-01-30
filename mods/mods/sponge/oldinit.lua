minetest.register_node("sponge:sponge", {
	description = "Sponge",
	drawtype = "normal",
	tiles = {"sponge.png"},
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	groups = {snappy=2, flammable=1},
	after_destruct = function(pos)
	        for i=-1,1 do
            for j=-1,1 do
            for k=-1,1 do
        p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
        n = minetest.env:get_node(p)
        if (n.name=="sponge:fake_air") then
            minetest.env:add_node(p, {name="air"})
                    end
                end
            end
	    end
    end,
})

minetest.register_node("sponge:iron_sponge", {
	description = "Iron Sponge",
	drawtype = "normal",
	tiles = {"iron_sponge.png"},
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	groups = {cracky=2},
	after_destruct = function(pos)
	        for i=-1,1 do
            for j=-1,1 do
            for k=-1,1 do
        p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
        n = minetest.env:get_node(p)
        if (n.name=="sponge:fake_air") then
            minetest.env:add_node(p, {name="air"})
                    end
                end
            end
	    end
    end,
})


minetest.register_node("sponge:fake_air", {
	description = "Fake Air",
	drawtype = "airlike",
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	groups = {not_in_creative_inventory=1},
})

minetest.register_abm({
    nodenames = {"default:water_source", "default:water_flowing"},
    neighbors = {"sponge:sponge", "sponge:iron_sponge"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
            minetest.env:add_node(pos, {name="sponge:fake_air"})
    end
})

minetest.register_abm({
    nodenames = {"default:lava_source", "default:lava_flowing"},
    neighbors = {"sponge:iron_sponge"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
            minetest.env:add_node(pos, {name="sponge:fake_air"})
    end
})

minetest.register_craft({
	output = "sponge:sponge",
	recipe = {
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:mese', 'default:leaves'},
		{'default:leaves', 'default:leaves', 'default:leaves'},
	}
})

minetest.register_craft({
	output = "sponge:iron_sponge",
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'sponge:sponge', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

