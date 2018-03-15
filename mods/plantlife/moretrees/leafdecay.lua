-- leaf decay

-- this function is based on the default leafdecay code
local process_drops = function(pos, name)
	local drops = minetest.get_node_drops(name)
	for _,dropitem in ipairs(drops) do
		if dropitem ~= name then
			local newpos = {
						x=pos.x + math.random() - 0.5,
						y=pos.y + math.random() - 0.5,
						z=pos.z + math.random() - 0.5
					}
			minetest.add_item(newpos, dropitem)
		end
	end
end

if moretrees.enable_leafdecay then
	for i in ipairs(moretrees.treelist) do
		local treename = moretrees.treelist[i][1]
		if treename ~= "jungletree" and treename ~= "fir" then
			minetest.register_abm({
				nodenames = "moretrees:"..treename.."_leaves",
				interval = moretrees.leafdecay_delay,
				chance = moretrees.leafdecay_chance,
				action = function(pos, node, active_object_count, active_object_count_wider)
					if minetest.find_node_near(pos, moretrees.leafdecay_radius, "moretrees:"..treename.."_trunk") then return end
					if minetest.find_node_near(pos, moretrees.leafdecay_radius, "ignore") then return end
					process_drops(pos, node.name)
					minetest.remove_node(pos)
					nodeupdate(pos)
				end
			})
		end
	end

	minetest.register_abm({
		nodenames = {"moretrees:jungletree_leaves_red","moretrees:jungletree_leaves_green","moretrees:jungletree_leaves_yellow"},
		interval = moretrees.leafdecay_delay,
		chance = moretrees.leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.find_node_near(pos, moretrees.leafdecay_radius, {"default:jungletree", "moretrees:jungletree_trunk"}) then return end
			if minetest.find_node_near(pos, moretrees.leafdecay_radius, "ignore") then return end
			process_drops(pos, node.name)
			minetest.remove_node(pos)
			nodeupdate(pos)
		end
	})

	minetest.register_abm({
		nodenames = {"moretrees:fir_leaves", "moretrees:fir_leaves_bright"},
		interval = moretrees.leafdecay_delay,
		chance = moretrees.leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.find_node_near(pos, moretrees.leafdecay_radius, "moretrees:fir_trunk") then return end
			if minetest.find_node_near(pos, moretrees.leafdecay_radius, "ignore") then return end
				process_drops(pos, node.name)
				minetest.remove_node(pos)
				nodeupdate(pos)
		end
	})

	minetest.register_abm({
		nodenames = "moretrees:palm_leaves",
		interval = moretrees.leafdecay_delay,
		chance = moretrees.leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.find_node_near(pos, moretrees.palm_leafdecay_radius, "moretrees:palm_trunk") then return end
			if minetest.find_node_near(pos, moretrees.palm_leafdecay_radius, "ignore") then return end
				process_drops(pos, node.name)
				minetest.remove_node(pos)
				nodeupdate(pos)
		end
	})
end

if moretrees.enable_default_leafdecay then

	minetest.register_abm({
		nodenames = "default:leaves",
		interval = moretrees.default_leafdecay_delay,
		chance = moretrees.default_leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.find_node_near(pos, moretrees.default_leafdecay_radius, "default:tree") then return end
			if minetest.find_node_near(pos, moretrees.default_leafdecay_radius, "ignore") then return end
			process_drops(pos, node.name)
			minetest.remove_node(pos)
			nodeupdate(pos)
		end
	})	
end

if moretrees.enable_default_jungle_leafdecay then

	minetest.register_abm({
		nodenames = "default:jungleleaves",
		interval = moretrees.default_jungle_leafdecay_delay,
		chance = moretrees.default_jungle_leafdecay_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.find_node_near(pos, moretrees.default_jungle_leafdecay_radius, "default:jungletree") then return end
			if minetest.find_node_near(pos, moretrees.default_jungle_leafdecay_radius, "ignore") then return end
			process_drops(pos, node.name)
			minetest.remove_node(pos)
			nodeupdate(pos)
		end
	})	
end

