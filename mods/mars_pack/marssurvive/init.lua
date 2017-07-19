marssurvive={player_space={},
itemdroptime=tonumber(minetest.setting_get("item_entity_ttl"))}--TODO move to aliens mod


if marssurvive.itemdroptime=="" or marssurvive.itemdroptime==nil then
	marssurvive.itemdroptime=880
else
	marssurvive.itemdroptime=hook_tmp_time-20
end

dofile(minetest.get_modpath("marssurvive") .. "/spacesuit.lua")
dofile(minetest.get_modpath("marssurvive") .. "/mapgen.lua")
dofile(minetest.get_modpath("marssurvive") .. "/nodes.lua")
dofile(minetest.get_modpath("marssurvive") .. "/functions.lua")
dofile(minetest.get_modpath("marssurvive") .. "/tools.lua")
dofile(minetest.get_modpath("marssurvive") .. "/bags.lua")
dofile(minetest.get_modpath("marssurvive") .. "/craft.lua")

function marssurvive_setgrav(player,grav)
	local aa= 1 - ((1-grav)*0.4)
	player:set_physics_override({gravity=grav, jump=aa})
end

-- seting up settings for joined players
minetest.register_on_joinplayer(function(player)
		player:override_day_night_ratio(12000)
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

function marssurvive_space(player)
	local pos=player:getpos().y
	if marssurvive.player_space[player:get_player_name()].inside~="cave" and pos<=-100 then
		marssurvive.player_space[player:get_player_name()].inside="cave"
		marssurvive_setgrav(player,0.3)
		minetest.after(0.1,function()
			player:set_sky(000000, "plain", {}, false)
		end)
	elseif marssurvive.player_space[player:get_player_name()].inside~="mars" and (pos>-100) and (pos<=1000) then
		marssurvive.player_space[player:get_player_name()].inside="mars"
		marssurvive_setgrav(player,0.3)
		minetest.after(0.1,function()
			player:set_sky({r=219, g=168, b=117},"plain",{}, false)
		end)
	elseif marssurvive.player_space[player:get_player_name()].inside~="space" and pos>1000 then
		marssurvive.player_space[player:get_player_name()].inside="space"
		marssurvive_setgrav(player,0.05)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"skybox",{"marssurvive_space_sky.png","marssurvive_space_sky.png^marssurvive_mars.png","marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky.png"})
		end)
	end


end

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
