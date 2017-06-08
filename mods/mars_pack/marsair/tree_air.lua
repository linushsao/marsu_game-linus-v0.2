

minetest.register_node("marsair:air_tree", {
	description = "10% Air 90% vacuum [You Hacker!]",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 180, r = 120, g = 120, b = 120},
	alpha = 20,
	tiles = {"marssurvive_air.png^[colorize:#E0E0E033"},
	groups = {marsair=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(marsairconfig.tree_air_disappear_time)
	end,
	on_timer = function (pos, elapsed)
		marssurvive.replacenode(pos)
	end,
})

marsair.registered_airleaves = {}
marsair.register_airleaves = function(name, trunk)
	local nodedef = minetest.registered_nodes[name]
	local groups = nodedef.groups
	groups.marsair_leaves = 1
	minetest.override_item(name, {
		groups = groups
	})
	
	local leavedef = {trunk = trunk}
	marsair.registered_airleaves[name] = leavedef
end

minetest.register_abm({
	label = "tree air generation",
	nodenames = {"group:marsair_leaves"},
	neighbors = {"air", "marsair:air_stable"},
	interval = marsairconfig.tree_air_time,
	chance = marsairconfig.tree_air_chance,
	action = function(pos)
		local node = minetest.get_node(pos)
		local trunk = marsair.registered_airleaves[node.name].trunk
		local replace_pos = minetest.find_node_near(pos, 1, "air") 
			or minetest.find_node_near(pos, 1, "marsair:air_stable")
		
		if type(trunk) == "table" then
			for i, v in pairs(trunk) do
				if minetest.find_node_near(pos, 4, v) then
					minetest.set_node(replace_pos, {name="marsair:air_tree"})
					return
				end
			end
		else
			if minetest.find_node_near(pos, 4, trunk) then
				minetest.set_node(replace_pos, {name="marsair:air_tree"})
				return
			end
		end
	end,
})


marsair.register_airleaves("default:leaves", "default:tree")
marsair.register_airleaves("default:bush_leaves", "default:bush_stem")
