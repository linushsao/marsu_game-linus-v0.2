local function give_player_item(playername, item)
	local stack = ItemStack(item)
	local player = minetest.get_player_by_name(playername)
	local inv = player:get_inventory()
	if inv:room_for_item("main", stack) then
		inv:add_item("main", stack)
	else
		minetest.item_drop(stack, player, player:getpos())
	end
end

local function randomgive(playername, questname) 
	rnd = math.random(1, 4)
	if rnd > 2 then return end
	local player = minetest.get_player_by_name(playername)
	local inv = player:get_inventory()
	if rnd == 1 then
		-- refill spacesuit
		local stack = inv:get_stack("main", 1)
		stack:set_wear(0)
		inv:set_stack("main", 1, stack)
		minetest.chat_send_player(playername, 
				"your spacesuit got refilled")
	elseif rnd == 2 then
		-- give apples
		give_player_item(playername, 
			"default:apple "..tostring(math.random(3)))
		minetest.chat_send_player(playername, "you got an apple")
	end
end

local function info(playername, questname, alternate)
	local quest = quests.registered_quests[questname]
	--print(questname, quest, dump(quests.registered_quests))
	quests.open_unified_inventory_craftguide(playername,
			quest.item_name, alternate)
end

local function get_info(after, alternate, close, itemname)
	if after == nil then after = 0 end
	if alternate == nil then alternate = 1 end
	--if close == nil then close = 100000000 end
	return function(playername, questname)
		if itemname == nil then 
			local quest = quests.registered_quests[questname]
			itemname = quest.item_name
		end
		minetest.after(after, function(name, itemname, alternate)
			quests.open_unified_inventory_craftguide(name,
				itemname, alternate)
			end, playername, itemname, alternate)
		if close then
			minetest.after(close+after, minetest.close_formspec,
				playername, "")
		end
	end
end


local function register(name, quest) 
	if quest.callback == nil then
		quest.callback = randomgive
	end
	quests.register_quest("mars:"..name, quest)
end


register("dig_sand", {
	title = "dig mars sand",
	description = "u find it everywhere",
	image = "default_desert_sand.png^[colorize:#cf411b66",
	max = 20, -- dig 20 sand
	next = "sandpick",
	autostart = true,
	item_name = "marssurvive:sand",
	type = "dig",
})


-- group sandpick
register("craft_sand", {
	title = "craft 20 normal sand",
	description = "u can craft normal sand from mars sand",
	image = "default_sand.png",
	max = 20, -- craft 20 sand
	autostart = false,
	item_name = "default:sand",
	type = "craft",
	group = "sandpick",
	next = "led",
	on_start = get_info(1,3),
})
register("craft_sandstone", {
	title = "craft 5 sandstone",
	description = "craft it from 4 sand in a square",
	image = "default_sandstone.png",
	max = 5,
	autostart = false,
	item_name = "default:sandstone",
	type = "craft",
	group = "sandpick",
	next = "led",
})
register("craft_sandpick", {
	title = "craft a sandstone\n pickaxe",
	description = "from 5 sandstone u can make a sand pickaxe",
	image = "default_tool_woodpick.png^[colorize:#cf411b66",
	autostart = false,
	item_name = "marssurvive:sandpick",
	type = "craft",
	group = "sandpick",
	next = "led",
	on_start = get_info(11, nil, 5),
})

-- group led
register("dig_coal", {
	title = "mine coal",
	description = 	"u should know coal :P",
	image = "default_coal_lump.png",
	max = 2,
	item_name = "marssurvive:stone_with_coal",
	type = "dig",
	group = "led",
	next = "furnace"
})
register("dig_clay1", {
	title = "dig mars clay",
	description = 	"u can find it in caves",
	image = "default_clay.png^[colorize:#863710aa",
	item_name = "marssurvive:clayblock",
	type = "dig",
	group = "led",
	next = "furnace",
})
register("craft_stick", {
	title = "craft stick from clay",
	description = "simply from clayblock",
	image = "default_stick.png",
	item_name = "default:stick",
	type = "craft",
	group = "led",
	next = "furnace",
	on_start = get_info(1),
})
register("craft_led", {
	title = "craft led (\"torch\")",
	description = 	"gives u an led",
	image = "default_stick.png^default_coal_lump.png",
	max = 8,
	item_name = "marssurvive:led",
	type = "craft",
	group = "led",
	next = "furnace",
	on_start = get_info(11, nil, 7),
})


-- group furnace
register("dig_stone", {
	title = "dig some stone",
	description = 	"best would be one where u can live in with only a"..
			" little entrance",
	image = "default_desert_stone.png^[colorize:#cf7d6788",
	max = 20,
	autostart = false,
	item_name = "marssurvive:stone",
	type = "dig",
	group = "furnace",
	next = "tree_mossy"
})
register("craft_furnace", {
	title = "craft a furnace",
	description = "from 8 mars stone",
	item_name = "default:furnace",
	image = "default_furnace_front.png",
	type = "craft", 
	autostart = false,
	group = "furnace",
	next = "tree_mossy"
})
register("place_furnace", {
	title = "place the furnace",
	description = "from 8 mars stone",
	item_name = "default:furnace",
	image = "default_furnace_front.png",
	type = "place", 
	autostart = false,
	group = "furnace",
	next = "tree_mossy"
})
register("dig_ice", {
	title = "mine ice",
	description = 	"u can find it at hills but"..
			" not over y = 200 or in a mine",
	image = "default_ice.png^[colorize:#ffffff99",
	max = 2,
	autostart = false,
	item_name = "marssurvive:ice",
	type = "dig",
	group = "furnace",
	next = "tree_mossy"
})
register("dig_coal", {
	title = "mine coal",
	description = 	"u should know coal :P",
	image = "default_coal_lump.png",
	max = 2,
	item_name = "marssurvive:stone_with_coal",
	type = "dig",
	group = "furnace",
	next = "tree_mossy"
})


-- group tree_mossy
register("place_water", {
	title = "place water on STONE!\ncook it from ice",
	description = "cook the water from ice and coal",
	image = "default_water.png",
	max = 1,
	autostart = false,
	item_name = "default:water_source",
	type = "place",
	group = "tree_mossy",
	next = "dirt",
	on_start = get_info(1),
})
register("craft_tree", {
	title = "craft mars sapling",
	description = "craft it from 8 clayblocks and one stick",
	image = "default_sapling.png^[colorize:#86371055",
	item_name = "marssurvive:mars_sapling",
	type = "craft", 
	autostart = false,
	group = "tree_mossy",
	next = "dirt",
	on_start = get_info(11, nil, 7),
})
register("dig_clay2", {
	title = "dig mars clay",
	description = 	"u can find it like ice but its more common",
	image = "default_clay.png^[colorize:#863710aa",
	max = 9,
	autostart = false,
	item_name = "marssurvive:clayblock",
	type = "dig",
	group = "tree_mossy",
	next = "dirt",
})
register("place_sapling", {
	title = "place sapling on sand",
	description = 	"simply do it",
	image = "default_sapling.png^[colorize:#86371055",
	max = 1,
	autostart = false,
	item_name = "marssurvive:mars_sapling",
	type = "place",
	group = "tree_mossy",
	next = "dirt",
})
register("dig_tree", {
	title = "dig the tree",
	description = 	"simply do it",
	image = "default_tree.png^[colorize:#86371055",
	max = 16,
	autostart = false,
	item_name = "marssurvive:tree",
	type = "dig",
	group = "tree_mossy",
	next = "dirt",
})



-- group dirt
register("dig_mossy_cobble", {
	title = "dig mossy cobble",
	description = "generates at stone near water",
	image = "default_mossycobble.png",
	max = 10,
	autostart = false,
	item_name = "default:mossycobble",
	type = "dig",
	group = "dirt",
	next = "wheat",
})
register("craft_wood", {
	title = "craft wood",
	description = "from mars tree trunk",
	image = "default_junglewood.png^[colorize:#86371055",
	max = 8,
	autostart = false,
	item_name = "marssurvive:wood",
	type = "craft",
	group = "dirt",
	next = "wheat",
})
register("craft_compost", {
	title = "craft compost",
	description = "from mossycobble",
	image = "compost_base.png",
	max = 10,
	autostart = false,
	item_name = "marssurvive:base_material",
	type = "craft",
	group = "dirt",
	next = "wheat",
	on_start = get_info(11, nil, 10)
})
register("craft_compost_barrel", {
	title = "craft compost barrel",
	description = "from 7 wood",
	image = "barrel_quest.png",
	max = 2,
	autostart = false,
	item_name = "marssurvive:wood_barrel",
	type = "craft",
	group = "dirt",
	next = "wheat",
	on_start = get_info(1),
})
register("place_compost_barrel", {
	title = "place compost barrel",
	description = "",
	image = "barrel_quest.png",
	max = 2,
	autostart = false,
	item_name = "marssurvive:wood_barrel",
	type = "place",
	group = "dirt",
	next = "wheat",
})

minetest.register_node("mars_quests:seed_wheat", {
	description = "Wheat Seed",
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		quests.do_quest("mars_quests:seed_wheat", 1, placer, "place")
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end,
})

register("place_dirt", {
	title = "place dirt",
	description = "put the unfirmented compost in barrel"..
		      "and u will get dirt",
	image = "default_dirt.png",
	max = 10,
	autostart = false,
	item_name = "default:dirt",
	type = "place",
	group = "dirt",
	next = "wheat",
	callback = function(playername, questname)
		give_player_item(playername, "farming:seed_wheat 10")
		give_player_item(playername, "marsair:air 32")
		give_player_item(playername, "marsair:airgen")
		give_player_item(playername, "doors:door_obsidian_glass")
		minetest.chat_send_player(playername, 
			"!!!You got 4 new item stacks!!!")
	end

})

-- group wheat
register("craft_hoe", {
	title = "craft stone hoe",
	description = "2 stone + 2 stick",
	image = "farming_tool_stonehoe.png",
	max = 2,
	autostart = false,
	item_name = "farming:hoe_stone",
	type = "craft",
	group = "wheat",
	next = "air",
})
register("place_seed", {
	title = "place some wheat",
	description = "u know how it works on normal minetest ...",
	image = "farming_wheat_seed.png",
	max = 10,
	autostart = false,
	item_name = "mars_quests:seed_wheat",
	type = "place",
	group = "wheat",
	next = "air",
})
register("place_airgen", {
	title = "place the airgen",
	description = "u need to place it inside a room",
	image = "marsquests_airgen.png",
	max = 1,
	autostart = false,
	item_name = "marsair:airgen",
	type = "place",
	group = "wheat",
	next = "air",
})
register("place_door", {
	title = "place the door",
	description = "to close the room for the airgen",
	image = "doors_item_obsidian_glass.png",
	max = 1,
	autostart = false,
	item_name = "doors:door_obsidian_glass_a",
	type = "place",
	group = "wheat",
	next = "air",
})
register("spread_air", {
	title = "spread air",
	description = "u need to place it inside a room which is closed!",
	image = "marsquests_airgen.png",
	max = 1,
	autostart = false,
	item_name = "marsair:airgen",
	type = "spread_air",
	group = "wheat",
	next = "air",
	on_start = function(playername, questname) 
		local player = minetest.get_player_by_name(playername)
		minetest.show_formspec(playername, "marsquests_spreadair", 
			"size[8.7,9]image[1,1;8,8;marsquests_spread.png")
	end
})







