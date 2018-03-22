marssurvive={player_space={},
itemdroptime=tonumber(minetest.settings:get("item_entity_ttl")),
gravity=0.6} --0.6 times the normal  gravity (1) should make a 3 block high jump ... more would be bad

if marssurvive.itemdroptime=="" or marssurvive.itemdroptime==nil then
	marssurvive.itemdroptime=880
else
	marssurvive.itemdroptime=hook_tmp_time-20
end

dofile(minetest.get_modpath("marssurvive") .. "/flowers.lua")
dofile(minetest.get_modpath("marssurvive") .. "/mapgen.lua")
dofile(minetest.get_modpath("marssurvive") .. "/nodes.lua")
dofile(minetest.get_modpath("marssurvive") .. "/functions.lua")
dofile(minetest.get_modpath("marssurvive") .. "/tools.lua")
dofile(minetest.get_modpath("marssurvive") .. "/bags.lua")
dofile(minetest.get_modpath("marssurvive") .. "/craft.lua")
dofile(minetest.get_modpath("marssurvive") .. "/compost.lua")

function marssurvive_setgrav(player,grav)
	player:set_physics_override({gravity=grav})
end


local function set_marssky(player) 
	minetest.after(0.1, function()
		local light = 12-math.abs(minetest.get_timeofday()*24-12)
		--twilight from 4-8 and 16-20
		if (light >= 8) then 
			player:set_sky({r=220, g=170, b=115},"plain",{}, false)
		elseif (light >= 4) and (light <= 8) then
			local im_top = "marssurvive_sky_twilight_top.png"
			local im = "marssurvive_sky_twilight_side.png"
			local im_bottom = "marssurvive_sky_twilight_bottom.png"
			player:set_sky({r=160, g=80, b=50}, "skybox",
				{im_top,im_bottom,im,im,im,im}, false)
		else
			local im_top = "marssurvive_sky_night_top.png"
			local im = "marssurvive_sky_night_side.png"
			local im_bottom = "marssurvive_sky_night_bottom.png"
			player:set_sky({r=100, g=80, b=50}, "skybox",
				{im_top,im_bottom,im,im,im,im}, false)
		end
	end)
end

local function marssurvive_space(player)
	local pos=player:getpos().y
	if marssurvive.player_space[player:get_player_name()].inside~="cave" and pos<=-100 then
		marssurvive.player_space[player:get_player_name()].inside="cave"
		marssurvive_setgrav(player,marssurvive.gravity)
		minetest.after(0.1,function()
			player:set_sky(000000, "plain", {}, false)
		end)
	elseif marssurvive.player_space[player:get_player_name()].inside~="mars"
	    and (pos>-100) and (pos<=1000) then
		marssurvive.player_space[player:get_player_name()].inside="mars"
		marssurvive_setgrav(player,marssurvive.gravity)
		set_marssky(player)
	elseif marssurvive.player_space[player:get_player_name()].inside~="space" and pos>1000 then
		marssurvive.player_space[player:get_player_name()].inside="space"
		marssurvive_setgrav(player,0.05)
		minetest.after(0.1,function()
			local im = "marssurvive_space_sky.png"
			player:set_sky({r=0, g=0, b=0},"skybox",
				{im,im,im,im,im,im}, false)
		end)
	elseif (pos>-100) and (pos<=1000) then
		set_marssky(player)
	end
end

-- seting up settings for joined players
minetest.register_on_joinplayer(function(player)
		--player:override_day_night_ratio(12000)
		marssurvive.player_space[player:get_player_name()]={inside=""}
		marssurvive_space(player)
		player:hud_add({
			hud_elem_type = "image",
			text ="marssurvive_scene.png",
			name = "mars_sky",
			scale = {x=-100, y=-100},
			position = {x=0, y=0},
			alignment = {x=1, y=1},
		})
end)


local timer = 0
minetest.register_globalstep(function(dtime)
	timer=timer+dtime
	if timer<5 then return end
	timer=0
	for i, player in pairs(minetest.get_connected_players()) do
		marssurvive_space(player)
	end
end)

--for doors and tools to remove whole door / to replace pos with air if enabled (overridden by marsair-mod)
marssurvive.replacenode = function(pos)
		minetest.set_node(pos, {name = "air"})
end

print("[MOD] Marssurvive loaded! (default marssurvive)")
