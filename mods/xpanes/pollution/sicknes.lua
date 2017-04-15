local pollution_rnmTimer=0
local pollution_rSnmTimer=0
local pollution_sicknes={}


function pollution_unsetsicknes(ob,n,p)

	if n then
		pollution_sicknes[n]=nil
		table.remove(pollution_sicknes,n)
		for _,o in ipairs(pollution_sicknes) do
			if o~=nil then return false end
		end
		pollution_sicknes={}
		return true
	end

	if ob.player or ob:is_player()==true then
		local name=ob:get_player_name()
		for i, obj in pairs(pollution_sicknes) do
			if obj.name==name then
		table.remove(pollution_sicknes,i) 

		if p then minetest.chat_send_player(ob:get_player_name(), "You are no longer sick") end

		for _,o in ipairs(pollution_sicknes) do
			if o~=nil then return false end
		end
		pollution_sicknes={}
		return true
		end
		end
	end
end


minetest.register_on_dieplayer(function(player)
pollution_unsetsicknes(player)
end)


function pollution_setsicknes(ob,rnd)
	if not ob then return false end
	if ob:get_hp()<=0 then return false end
	local sicknes=math.random(5)
	local object=0
	if rnd then sicknes=1 end
	if ob:is_player()==true then -- 1=player  2=enitity
		object=1
	else
		object=2
	end
	if sicknes<=2 and object==2 then
		local sicknes_dmg=math.random (4)
		local sicknes_tim=math.random (200)
		local sicknes_dmgchanse=math.random (4)
		for i, sick in pairs(pollution_sicknes) do
			if not sick.player then
				if sick.object==nil or sick.object:getpos()==nil then pollution_unsetsicknes(ob,i) return false end
				if sick.object:getpos().x==ob:getpos().x then return false end
			end
		end
		table.insert(pollution_sicknes,{object=ob, time=sicknes_tim,dmg=sicknes_dmg,chanse=sicknes_dmgchanse})
	end




	if sicknes<=2 and object==1 then
		local sicknes_dmg=math.random (4)
		local sicknes_tim=math.random (200)
		local sicknes_dmgchanse=math.random (4)
		local player_name=ob:get_player_name()
		local ss=0
		for i, sick in pairs(pollution_sicknes) do
			if sick.name==player_name then ss=1 break end
		end
		if ss==1 then return false end
		table.insert(pollution_sicknes,{name=player_name, time=sicknes_tim,dmg=sicknes_dmg,chanse=sicknes_dmgchanse,player=1})
		minetest.chat_send_player(player_name, "You are sick: swim in the water or eat a magnesium lump")
	end

end

minetest.register_tool("pollution:trifle", {
	description = "Toxic rifle",
	range = 7,
	inventory_image = "pollution_trifle.png",
		on_use = function(itemstack, user, pointed_thing)
		pollution_setsicknes(pointed_thing.ref,1)
		pollution_sound_shoot(user:getpos(),2)
		return itemstack
		end,
})


minetest.register_globalstep(function(dtime)
	pollution_rnmTimer=pollution_rnmTimer+dtime
	pollution_rSnmTimer=pollution_rSnmTimer+dtime
	if pollution_rnmTimer>5 then 
		pollution_rnmTimer=0
		local sicknes=math.random (5)
		local ppos
		for i, player in pairs(minetest.get_connected_players()) do
			ppos=player:getpos()
			local name=minetest.get_node(ppos).name

			--if swiming in toxic water
			if name=="pollution:water_source" or name=="pollution:water_flowing" then
						pollution_setsicknes(player)
			end
		end
		return true
	end

	if pollution_rSnmTimer>5 and math.random (5)==1 then
	pollution_rSnmTimer=0
		for i, ob in pairs(pollution_sicknes) do
		

			if ob.player then
				local player=minetest.get_player_by_name(ob.name)
				local dmg=math.random (4)
				local chanse=math.random (5)
				if player==nil and ob.chanse<=chanse then
					ob.time=ob.time-1
					if ob.time<=0 then pollution_unsetsicknes(ob,i) end
					return true
				end
				if player==nil then
					pollution_unsetsicknes(ob,i)
					return true	
				end
				
				if ob.chanse<=chanse and player:get_player_name()==ob.name then
					pollution_sound_cough(player:getpos())
					local is_online=0
					for ii, pplayer in pairs(minetest.get_connected_players()) do
					if pplayer:get_player_name()==ob.name then is_online=1 break end
				end
				player:set_hp(player:get_hp()-ob.dmg)
-- if sick and inside toxic water - 2x damage
				local name=minetest.get_node(player:getpos()).name
				if name=="pollution:water_source" or name=="pollution:water_flowing" then
					player:set_hp(player:get_hp()-(ob.dmg*3))
				end
-- if sick and near another player
				for _,object in ipairs(minetest.get_objects_inside_radius(player:getpos(), 3)) do
						pollution_setsicknes(object,1)
				end
-- kill longer sicknes
				ob.time=ob.time-1
				if ob.time<=0 or minetest.get_node(player:getpos()).name=="default:water_source" then
					minetest.chat_send_player(ob.name, "You are no longer sick")
					pollution_unsetsicknes(ob,i)
				end
			end

			else-- if not a player
				local dmg=math.random (4)
				local chanse=math.random (5)

				if ob and ob.chanse<=chanse then
					ob.time=ob.time-1
					if ob.time<=0 then table.remove(pollution_sicknes,i)
						pollution_unsetsicknes(ob,i)
						chanse=-1
					end
					
				end

				if ob.object==nil or ob.object:getpos()==nil then
					chanse=-1
					pollution_unsetsicknes(ob,i)
				end

				if ob.chanse<=chanse then

				pollution_sound_cough(ob.object:getpos())
-- if sick and inside toxic water - 2x damage

				local name=minetest.get_node(ob.object:getpos()).name
				if name=="pollution:water_source" or name=="pollution:water_flowing" then
					ob.object:set_hp(ob.object:get_hp()-(ob.dmg*3))
				end
-- if sick and near another
				for _,object in ipairs(minetest.get_objects_inside_radius(ob.object:getpos(), 3)) do

					if ob.object~=object or object:is_player() then
						pollution_setsicknes(object,1)
					end
				end

-- kill longer sicknes

				ob.time=ob.time-1
				ob.object:set_hp(ob.object:get_hp()-ob.dmg)
				if ob.time<=0 or minetest.get_node(ob.object:getpos()).name=="default:water_source" or ob.object:get_hp()<=0 then
					pollution_unsetsicknes(ob,i)
					ob.object:remove()
				end
					ob.object:punch(ob.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)

				end
		end
	end
	end

end)