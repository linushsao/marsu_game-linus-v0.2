pollution_waste_nitrogen_radius=30
pollution_waste_toxic_radius=30
pollution_mobs_max_number=20
pollution_mobs_axov_max_number=10
pollution={}

pollution_mobs={}
pollution_mobs_axov={}
function pollution_round(x)
if x%2 ~= 0.5 then
return math.floor(x+0.5)
end
return x-0.5
end

function pollution_getLength(a)
if a==nil then return 0 end
	local count = 0
	for _ in pairs(a) do count = count + 1 end
	return count
end


function pollution_mobs_max(add,axov,type) --type = use add
	if axov then
		local c=0
		for i in pairs(pollution_mobs_axov) do
			c=c+1
			if pollution_mobs_axov[i]:getpos()==nil then
				table.remove(pollution_mobs_axov,c)
				c=c-1
			end
		end
		if c+1>pollution_mobs_axov_max_number then return false end
		if add and type then
			table.insert(pollution_mobs_axov,add)
			return true
		end
		return true
	end

	local c=0
	for i in pairs(pollution_mobs) do
		c=c+1
		if pollution_mobs[i]:getpos()==nil then
			table.remove(pollution_mobs,c)
			c=c-1
		end
	end
	if c+1>pollution_mobs_max_number then return false end
	if add then
		table.insert(pollution_mobs,add)
		return true
	end
	return true
end


function pollution_sound_lightning(pos) minetest.sound_play("pollution_lightning", {pos=pos, gain = 1, max_hear_distance = 5,}) end
function pollution_sound_punsh(pos) minetest.sound_play("pollution_punsh", {pos=pos, gain = 1.0, max_hear_distance = 10,}) end
function pollution_sound_hard_punch(pos) minetest.sound_play("pollution_hard_punch", {pos=pos, gain = 1.0, max_hear_distance = 5,}) end
function pollution_sound_pff(pos) minetest.sound_play("pollution_pff", {pos=pos, gain = 2.0, max_hear_distance = 10,}) end
function pollution_sound_cough(pos) minetest.sound_play("pollution_cough", {pos=pos, gain = 1.0, max_hear_distance = 10,}) end
function pollution_sound_shoot(pos,n) minetest.sound_play("pollution_shoot_" .. n, {pos=pos, gain = 1.0, max_hear_distance = 10,}) end
dofile(minetest.get_modpath("pollution") .. "/sicknes.lua")
dofile(minetest.get_modpath("pollution") .. "/toxic.lua")
--[[
dofile(minetest.get_modpath("pollution") .. "/nitrogen.lua")
dofile(minetest.get_modpath("pollution") .. "/sinkhole.lua")
dofile(minetest.get_modpath("pollution") .. "/craft.lua")
dofile(minetest.get_modpath("pollution") .. "/kalium.lua")
dofile(minetest.get_modpath("pollution") .. "/grow.lua")
dofile(minetest.get_modpath("pollution") .. "/extras.lua")
dofile(minetest.get_modpath("pollution") .. "/axov.lua")
dofile(minetest.get_modpath("pollution") .. "/crystal.lua")
dofile(minetest.get_modpath("pollution") .. "/syra.lua")
dofile(minetest.get_modpath("pollution") .. "/nuclear.lua")
dofile(minetest.get_modpath("pollution") .. "/quicksand.lua")
]]
