-- Minetest 0.4 mod: bones
-- See README.txt for licensing and other information.

is_dead = {}

--[[
bones = {}
local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name then
		return true
	end
	return false
end
bones.bones_formspec =
	"size[8,9]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;main;0,0.3;8,4;]"..
	"list[current_player;main;0,4.85;8,1;]"..
	"list[current_player;main;0,6.08;8,3;8]"..
	default.get_hotbar_bg(0,4.85)
local share_bones_time = tonumber(minetest.setting_get("share_bones_time") or 1200)
local share_bones_time_early = tonumber(minetest.setting_get("share_bones_time_early") or (share_bones_time/4))
--]]

minetest.register_node("bones:bones_infected", {
	description = "Bones infected by virus.",
	tiles = {
		"bones_top.png",
		"bones_bottom.png",
		"bones_side.png",
		"bones_side.png",
		"bones_rear.png",
		"bones_front.png"
	},
	paramtype2 = "facedir",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 3,

	groups = {dig_immediate=2},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		minetest.add_entity({x=pos.x,y=pos.y+1,z=pos.z},"marssurvive:alien_sand")
		minetest.set_node({x=pos.x,y=pos.y,z=pos.z},{name="marssurvive:sand"})
		itemstack:take_item(1)
		return itemstack

	end,
	})




local function may_replace(pos, player)
	local node_name = minetest.get_node(pos).name
	local node_definition = minetest.registered_nodes[node_name]

	-- if the node is unknown, we let the protection mod decide
	-- this is consistent with when a player could dig or not dig it
	-- unknown decoration would often be removed
	-- while unknown building materials in use would usually be left
	if not node_definition then
		-- only replace nodes that are not protected
		return not minetest.is_protected(pos, player:get_player_name())
	end

	-- allow replacing air and liquids
	if node_name == "air" or node_definition.liquidtype ~= "none" then
		return true
	end

	-- don't replace filled chests and other nodes that don't allow it
	local can_dig_func = node_definition.can_dig
	if can_dig_func and not can_dig_func(pos, player) then
		return false
	end

	-- default to each nodes buildable_to; if a placed block would replace it, why shouldn't bones?
	-- flowers being squished by bones are more realistical than a squished stone, too
	-- exception are of course any protected buildable_to
	return node_definition.buildable_to and not minetest.is_protected(pos, player:get_player_name())
end



minetest.register_on_dieplayer(function(player)

	local pos = player:getpos()
	local choice
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+0.5)
	pos.z = math.floor(pos.z+0.5)

	local param2 = minetest.dir_to_facedir(player:get_look_dir())

	if may_replace(pos, player) then
--		minetest.chat_send_all("may_replace:true")
		choice = math.random(1, 3)
--		minetest.chat_send_all("choice:"..choice)

		if (choice == 1 and pos.y <-300) then
			minetest.set_node(pos, {name="bones:bones_infected", param2=param2})
			minetest.chat_send_all("Somebody die at ("..pos.x..","..pos.y..","..pos.z..") ,")
--			minetest.chat_send_all("and the corpse is infected by unknown virus in dirt of mars.")
--			minetest.chat_send_all("Break the infected bone,or keep the weapon and Beware the Night...")

		end
	end

end)
