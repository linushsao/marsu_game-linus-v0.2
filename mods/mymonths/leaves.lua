
--Nodes #################

local leaves_table = {
	'pale_green', 'orange', 'red', 'blooms', 'acacia_blooms',
	'orange_aspen', 'red_aspen', 'aspen_blooms', 'yellow_aspen','sticks'}

local sticks_table = {'default', 'aspen'}

--linus added for moretrees
local moretrees_leaves_table = {"default:acacia_leaves","default:aspen_leaves","default:jungleleaves"
                               ,"moretrees:apple_tree_leaves","moretrees:beech_leaves","moretrees:birch_leaves","moretrees:cedar_leaves"
							   ,"moretrees:date_palm_leaves","moretrees:fir_leaves","moretrees:fir_leaves_bright","moretrees:jungletree_leaves_red"
							   ,"moretrees:jungletree_leaves_yellow","moretrees:oak_leaves","moretrees:palm_leaves","moretrees:poplar_leaves"
							   ,"moretrees:rubber_tree_leaves","moretrees:sequoia_leaves","moretrees:spruce_leaves"}

local v1


for i, name in pairs(leaves_table) do

	minetest.register_node('mymonths:leaves_' .. name, {
		description = name .. ' leaves',
		drawtype = 'allfaces_optional',
		waving = 1,
		visual_scale = 1.3,
		tiles = {'mymonths_leaves_' .. name .. '.png'},
		paramtype = 'light',
		is_ground_content = false,
		groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
		sounds = default.node_sound_leaves_defaults(),
		after_place_node = default.after_place_leaves,
	})

	for _,v in pairs(moretrees_leaves_table) do

			if string.match(v,"moretrees") then v1 = string.gsub(v,"moretrees:","") end
			if string.match(v,"default")   then v1 = string.gsub(v,"default:","") end

			print('mymonths:leaves_' .. name.."_"..v1)

			minetest.register_node('mymonths:leaves_' .. name.."_"..v1, {
				description = v1.."_"..name .. ' leaves',
				drawtype = 'allfaces_optional',
				waving = 1,
				visual_scale = 1.3,
				tiles = {'mymonths_leaves_' .. name .. '.png'},
				paramtype = 'light',
				is_ground_content = false,
				groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1,leaves_change=1},
				sounds = default.node_sound_leaves_defaults(),
				after_place_node = default.after_place_leaves,
			})
	end

end

for i, name in pairs(sticks_table) do

	minetest.register_node('mymonths:sticks_' .. name, {
	description = 'Sticks',
	drawtype = 'allfaces_optional',
	waving = 1,
	visual_scale = 1.3,
	tiles = {'mymonths_sticks.png'},
	paramtype = 'light',
	is_ground_content = false,
	drop = 'mymonths:leaves_sticks 2',
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	})

	for _,v in pairs(moretrees_leaves_table) do

			if string.match(v,"moretrees") then v1 = string.gsub(v,"moretrees:","") end
			if string.match(v,"default") then   v1 = string.gsub(v,"default:","") end

			minetest.register_node('mymonths:sticks_' .. name.."_"..v1, {
			description = v1.."_"..'Sticks',
			drawtype = 'allfaces_optional',
			waving = 1,
			visual_scale = 1.3,
			tiles = {'mymonths_sticks.png'},
			paramtype = 'light',
			is_ground_content = false,
			drop = 'mymonths:leaves_sticks 2',
			groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, sticks_change =1},
			})
	end
end



for _,v in pairs(moretrees_leaves_table) do
	if not string.match(v,"default") then
		local v1 = string.gsub(v,"moretrees:","")

		minetest.register_craft({
			output = "default:stick 2",
			recipe = {
						{ "mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1 },
						{ "mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1 },
						{ "mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1,"mymonths:leaves_sticks_"..v1 },
					}
		})
	else
		minetest.register_craft({
			output = "default:stick 2",
			recipe = {
						{ "mymonths:leaves_sticks","mymonths:leaves_sticks","mymonths:leaves_sticks" },
						{ "mymonths:leaves_sticks","mymonths:leaves_sticks","mymonths:leaves_sticks" },
						{ "mymonths:leaves_sticks","mymonths:leaves_sticks","mymonths:leaves_sticks" },
					}
		})

	end
end


--ABMs ##################

--All leaves should be pale green by August
minetest.register_abm({
	nodenames = {'default:leaves','group:moretrees_leaves'},
	interval = 600,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if (mymonths.month_counter == 8) then
			print("action of Autust")
			if (string.match(node.name,"default")) or (string.match(node.name,"moretrees"))  then --leave start change
				if (string.match(node.name,"default")) then minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})  end
				if (string.match(node.name,"moretrees")) then
					local v1 = string.gsub(node.name,"moretrees:","")
					minetest.set_node(pos, {name = 'mymonths:leaves_pale_green_'..v1})
				end

--			minetest.set_node(pos, {name = 'mymonths:leaves_pale_green'})
			end
		end

	end
})

--All papyrus should be die after sandstorm's season
minetest.register_abm({
	nodenames = {'default:papyrus'},
	interval = 601,
	chance = 10,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if (mymonths.month_counter == 2 and mymonths.month_counter <=3 ) then
			minetest.set_node(pos, {name = 'air'})
		end
	end
})


--All leaves should be orange by September
minetest.register_abm({
	nodenames = {'group:leaves_change','mymonths:leaves_pale_green'},
	interval = 602,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if (mymonths.month_counter == 9) then
					print("action of September")

			if node.name == 'mymonths:leaves_pale_green' then minetest.set_node(pos, {name = 'mymonths:leaves_orange'})  --by default blabla
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
						minetest.set_node(pos, {name = 'mymonths:leaves_orange_'..v1})
					end
				end
			end
--			minetest.set_node(pos, {name = 'mymonths:leaves_orange'})
		end
	end
})

--All leaves should be red by mid October
minetest.register_abm({
nodenames = {'group:leaves_change','mymonths:leaves_orange'},
--	nodenames = {'default:leaves','group:moretrees_leaves','mymonths:leaves_pale_green','mymonths:leaves_orange'},

	interval = 603,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if (mymonths.month_counter == 10) then
					print("action of October")

			if node.name == 'mymonths:leaves_orange' then minetest.set_node(pos, {name = 'mymonths:leaves_red'}) --by default blabla
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
						minetest.set_node(pos, {name = 'mymonths:leaves_red_'..v1})
					end
				end
			end
--			minetest.set_node(pos, {name = 'mymonths:leaves_red'})
		end
	end
})


--All default leaves should be sticks in November and December
minetest.register_abm({
	nodenames = {'group:leaves_change','mymonths:leaves_red', 'mymonths:leaves_red_aspen'},
	interval = 604,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 11
		or mymonths.month_counter == 12
		or mymonths.month_counter == 1
		or mymonths.month_counter == 2 then
					print("action of Novemer - febur")

			if node.name == 'mymonths:leaves_red' or 'mymonths:leaves_red_aspen' then
				minetest.set_node(pos, {name = 'mymonths:sticks_default'})
				else
					for _,v in pairs(moretrees_leaves_table) do
						local v1 = string.gsub(v,"moretrees:","")
						if string.match(node.name,v1) then
							minetest.set_node(pos, {name = 'mymonths:leaves_sticks_'..v1})
						end
					end
			end
--			minetest.set_node(pos, {name = 'mymonths:sticks_default'})
		 end
	 end
})

--All aspen leaves should be sticks in November and December
minetest.register_abm({
	nodenames = {'default:aspen_leaves', 'mymonths:leaves_orange_aspen', 'mymonths:leaves_red_aspen',},
	interval = 605,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 12
		or mymonths.month_counter == 1
		or mymonths.month_counter == 2 then
			if node.name == 'default:aspen_leaves' then
				minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})
				else
					for _,v in pairs(moretrees_leaves_table) do
						local v1 = string.gsub(v,"moretrees:","")
						if string.match(node.name,v1) then
							minetest.set_node(pos, {name = 'mymonths:sticks_aspen_'..v1})
						end
					end
			end

--			minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})
		end
	end
})

--New growth in spring
minetest.register_abm({
	nodenames = {'group:sticks_change','mymonths:sticks_default', 'mymonths:leaves_blooms', 'mymonths:sticks_aspen', 'mymonths:leaves_aspen_blooms'},
	interval = 606,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 3
		or mymonths.month_counter == 4 then

			if node.name == 'mymonths:sticks_default' then
				minetest.set_node(pos, {name = 'mymonths:leaves_blooms'})
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
					minetest.set_node(pos, {name = 'mymonths:leaves_blooms_'..v1})
					end
				end
			end

			if node.name == 'mymonths:leaves_blooms' then
				minetest.set_node(pos, {name = 'default:leaves'})
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
					minetest.set_node(pos, {name = v })
					end
				end
			end

			if node.name == 'mymonths:leaves_stick' then
			print("LEAVES STICKS")
				minetest.set_node(pos, {name = 'default:leaves'})
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
					minetest.set_node(pos, {name = v })
					end
				end
			end

			if node.name == 'mymonths:sticks_aspen' then
				minetest.set_node(pos, {name = 'mymonths:leaves_aspen_blooms'})
			else
				for _,v in pairs(moretrees_leaves_table) do
					local v1 = string.gsub(v,"moretrees:","")
					if string.match(node.name,v1) then
				minetest.set_node(pos, {name = 'mymonths:leaves_aspen_blooms'..v1})
					end
				end
			end

			if node.name == 'mymonths:leaves_aspen_blooms' then
				minetest.set_node(pos, {name = 'default:aspen_leaves'})
			else
					for _,v in pairs(moretrees_leaves_table) do
						local v1 = string.gsub(v,"moretrees:","")
						if string.match(node.name,v1) then
							minetest.set_node(pos, {name = 'mymonths:aspen_leaves_'..v1})
						end
					end
--			minetest.set_node(pos, {name = 'mymonths:sticks_aspen'})
			end
		end
	end
})

--By April all trees should be back to normal
minetest.register_abm({
	nodenames = {'group:leaves_change','mymonths:sticks_default','mymonths:leaves_sticks', 'mymonths:leaves_blooms', 'mymonths:sticks_aspen', 'mymonths:leaves_aspen_blooms'},
	interval = 607,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 5 then

			if node.name == 'mymonths:sticks_default'
			or node.name == 'mymonths:leaves_sticks'
			or node.name == 'mymonths:leaves_blooms' then
				minetest.set_node(pos, {name = 'default:leaves'})

			elseif node.name =='mymonths:sticks_aspen'
				or node.name == 'mymonths:leaves_aspen_blooms' then
				minetest.set_node(pos, {name = 'default:aspen_leaves'})
			else
				for _,v in pairs(moretrees_leaves_table) do
						local v1 = string.gsub(v,"moretrees:","")
						if string.match(node.name,v1) then
							minetest.set_node(pos, {name = v})
						end
				end

			end
		end
	end
})

--apples die in November
minetest.register_abm({
	nodenames = {'default:apple'},
	interval = 608,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		local nodeu1 = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
		local nodeu2 = minetest.get_node({x = pos.x, y = pos.y - 2, z = pos.z})
		local nodeu3 = minetest.get_node({x = pos.x, y = pos.y - 3, z = pos.z})
		local nodeu4 = minetest.get_node({x = pos.x, y = pos.y - 4, z = pos.z})

		if mymonths.month_counter == 11 then

			if nodeu1.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 1,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu2.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 2,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu3.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 3,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			elseif nodeu4.name == "air" then

				minetest.spawn_item({
					x = pos.x,
					y = pos.y - 4,
					z = pos.z}, 'default:apple')

				minetest.set_node(pos,{name = 'mymonths:sticks_default'})

			else
				minetest.set_node(pos,{name = 'mymonths:sticks_default'})
			end
		end
	end
})

--apples grow in fall
minetest.register_abm({
	nodenames = {'default:leaves'},
	interval = 609,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 7
		or mymonths.month_counter == 8
		or mymonths.month_counter == 9 then

			local a = minetest.find_node_near(pos, 3, 'default:apple')

			if a == nil then
				minetest.set_node(pos,{name = 'default:apple'})
			end
		end
	end
})

--apples change to leaves or sticks is not in season
minetest.register_abm({
	nodenames = {'default:apple'},
	interval = 610,
	chance = 10,

	action = function (pos, node, active_object_count, active_object_count_wider)

		if mymonths.month_counter == 12
		or mymonths.month_counter == 1
		or mymonths.month_counter == 2 then

			minetest.set_node(pos,{name = 'mymonths:sticks_default'})

		elseif mymonths.month_counter == 3
		or mymonths.month_counter == 4 then

			minetest.set_node(pos,{name = 'mymonths:leaves_blooms'})

		elseif mymonths.month_counter == 5
		or mymonths.month_counter == 6 then

			minetest.set_node(pos,{name = 'default:leaves'})
		end
	end
})
