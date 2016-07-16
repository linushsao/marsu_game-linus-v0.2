marssurvive={breath_timer=0,player_sp={},air=21,player_space={},
itemdroptime=tonumber(minetest.setting_get("item_entity_ttl")),
aliens={},aliens_max=4}


if marssurvive.itemdroptime=="" or marssurvive.itemdroptime==nil then
	marssurvive.itemdroptime=880
else
	marssurvive.itemdroptime=hook_tmp_time-20
end


dofile(minetest.get_modpath("marssurvive") .. "/mapgen.lua")
dofile(minetest.get_modpath("marssurvive") .. "/nodes.lua")
dofile(minetest.get_modpath("marssurvive") .. "/craft.lua")
dofile(minetest.get_modpath("marssurvive") .. "/functions.lua")
dofile(minetest.get_modpath("marssurvive") .. "/aliens.lua")




minetest.register_tool("marssurvive:sp", {
	description = "Spacesuit (wear slot 1)",
	range = 4,
	inventory_image = "marssurvive_sp.png",
})

-- adding spacesuit to new players
minetest.register_on_newplayer(function(player)
	local inv=player:get_inventory()
	inv:add_item("main","marssurvive:sp")
	inv:add_item("main","marssurvive:sandpick")
	inv:add_item("main","marssurvive:air_gassbotte 3")
	inv:add_item("main","default:lamp_wall")
	inv:add_item("main","default:apple 3")
	inv:add_item("main","farming:bread 3")
	inv:add_item("main","protector:protect")

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
			player:set_sky({r=219, g=168, b=117},"plain",{})
		end)
	elseif marssurvive.player_space[player:get_player_name()].inside==1 and pos>1000 then
		marssurvive.player_space[player:get_player_name()].inside=0
		marssurvive_setgrav(player,0.1)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"skybox",{"marssurvive_space_sky.png","marssurvive_space_sky.png^marssurvive_mars.png","marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky.png"})
		end)
	end


end


minetest.register_entity("marssurvive:sp1",{
	hp_max = 100,
	physical = false,
	weight = 0,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "mesh",
	mesh="marssurvive_sp.obj",
	visual_size = {x=0.5, y=0.5},
	textures = {"default_steel_block.png","default_obsidian.png^[colorize:#927C3044","default_cloud.png","default_steel_block.png","default_cloud.png","default_cloud.png"},
	spritediv = {x=1, y=1},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,

on_activate=function(self, staticdata)
		if marssurvive.tmpuser then
			self.user=marssurvive.tmpuser
			marssurvive.tmpuser=nil
		else
			self.object:remove()
		end
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<2 then return end
		self.timer=0
		if (not self.user:get_player_name()) or marssurvive.player_sp[self.user:get_player_name()]==nil then
			self.object:set_hp(0)
			self.object:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
			return self
		end

		if self.user:get_inventory():get_stack("main", 1):get_name()~="marssurvive:sp" then
			self.object:set_detach()
			self.user:set_properties({mesh = "character.b3d",textures = marssurvive.player_sp[self.user:get_player_name()].skin})
			marssurvive.player_sp[self.user:get_player_name()].skin={}
			marssurvive.player_sp[self.user:get_player_name()].sp=0
			self.object:remove()
		end
	end,
})
