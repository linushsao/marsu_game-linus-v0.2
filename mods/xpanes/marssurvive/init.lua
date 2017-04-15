marssurvive={breath_timer=0,player_sp={},air=21,player_space={},
itemdroptime=tonumber(minetest.setting_get("item_entity_ttl")),
aliens={},aliens_max=math.random(7,14)}


if marssurvive.itemdroptime=="" or marssurvive.itemdroptime==nil then
	marssurvive.itemdroptime=880
else
	marssurvive.itemdroptime=hook_tmp_time-20
end

dofile(minetest.get_modpath("marssurvive") .. "/spacesuit.lua")
dofile(minetest.get_modpath("marssurvive") .. "/mapgen.lua")
dofile(minetest.get_modpath("marssurvive") .. "/nodes.lua")
dofile(minetest.get_modpath("marssurvive") .. "/craft.lua")
dofile(minetest.get_modpath("marssurvive") .. "/functions.lua")
dofile(minetest.get_modpath("marssurvive") .. "/aliens.lua")


-- adding spacesuit to new players
minetest.register_on_newplayer(function(player)
	local inv=player:get_inventory()
	inv:add_item("main","marssurvive:sp")
	inv:add_item("main","marssurvive:sandpick")
	inv:add_item("main","marssurvive:air_gassbotte 3")
	inv:add_item("main","default:lamp_wall")
	inv:add_item("main","default:apple 6")
	inv:add_item("main","farming:bread 9")
	inv:add_item("main","markers:mark 4")

	--if minetest.check_player_privs(player:get_player_name(), {server=true}) then
	--	inv:add_item("main","marssurvive:tospaceteleporter")
	--end
end)


function marssurvive_setgrav(player,grav)
	player:set_physics_override({gravity=grav})
	local aa= 1 - ((1-grav)*0.4)
	player:set_physics_override({jump=aa})
end


-- seting up settings for joined players
minetest.register_on_joinplayer(function(player)
--		player:override_day_night_ratio(12000)
		marssurvive.player_sp[player:get_player_name()]={sp=0,skin={}}
		if player:getpos().y<=1000 then
			marssurvive.player_space[player:get_player_name()]={inside=0}
		else
			marssurvive.player_space[player:get_player_name()]={inside=1}
		end
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
	if marssurvive.player_space[player:get_player_name()].inside==0 and pos<=1000 then
		marssurvive.player_space[player:get_player_name()].inside=1
		marssurvive_setgrav(player,0.5)

		minetest.after(0.1,function()
			local ratio = minetest.get_timeofday() --linus added
			sky_change(player,ratio)--linus added
			--[[
			if ratio < 0.5 then ratio = 1*(ratio/0.5)
			else
				ratio = (1-ratio)/0.5
			end
			player:set_sky({r=math.floor(219*ratio), g=math.floor(168*ratio), b=math.floor(117*ratio)},"plain",{})
			--]]
		end)
	elseif marssurvive.player_space[player:get_player_name()].inside==1 and pos>1000 then
		marssurvive.player_space[player:get_player_name()].inside=0
		marssurvive_setgrav(player,0.1)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"skybox",{"marssurvive_space_sky0.png","marssurvive_space_sky0.png^marssurvive_mars.png","marssurvive_space_sky0.png","marssurvive_space_sky0.png","marssurvive_space_sky0.png","marssurvive_space_sky0.png"})
		end)
	end


end
