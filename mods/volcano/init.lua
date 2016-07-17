-- volcano 0.1.1 by paramat
-- For latest stable Minetest and back to 0.4.6
-- Depends default
-- Licenses: Code WTFPL. Textures CC BY-SA. Ash is recoloured default sand by VanessaE 

-- Parameters

local CONDINT = 19 --  -- Conduit forming abm interval
local CONDCHA = 1 --  -- 1/x chance per ore node directly above lava
local MAGFINT = 23 --  -- Magma rise fast abm interval
local MAGFCHA = 1 --  -- 1/x chance per "magma_fast"
local MAGZINT = 29 --  -- Magma y = zero abm interval
local MAGZCHA = 1 --  -- 1/x chance per "magma_zero"
local MAGSINT = 57 --  -- Magma rise slow abm interval
local MAGSCHA = 2 --  -- 1/x chance per "magma_slow"
local COOLINT = 17 --  -- Lava flow cooling abm interval
local COOLCHA = 3 --  -- 1/x chance per "magma_flowing"

local MAXALT = 63 --  -- Maximum y of volcano
local MAXRAD = 3 --  -- Maximum radius of vent
local LAVCHA = 1.5 --  -- Average number of lava flows from vent perimeter
local ASHTHR = 0.1 --  -- Ash noise threshold 

-- 3D Perlin noise for ash nodes

local SEEDDIFF1 = 3673967
local OCTAVES1 = 4 -- 
local PERSISTENCE1 = 0.6 -- 
local SCALE1 = 64 -- 

-- Stuff

volcano = {}

-- Nodes

minetest.register_node("volcano:magma_fast", {
	description = "Magma Rising Fast",
	inventory_image = minetest.inventorycube("default_lava.png"),
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

minetest.register_node("volcano:magma_zero", {
	description = "Magma Zero",
	inventory_image = minetest.inventorycube("default_lava.png"),
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

minetest.register_node("volcano:magma_slow", {
	description = "Magma Rising Slow",
	inventory_image = minetest.inventorycube("default_lava.png"),
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

minetest.register_node("volcano:magma_flowing", {
	description = "Magma Flowing",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	special_tiles = {
		{
			image="default_lava_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
		{
			image="default_lava_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "volcano:magma_flowing",
	liquid_alternative_source = "volcano:magma_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1, not_in_creative_inventory=1},
})

minetest.register_node("volcano:magma_source", {
	description = "Magma Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name="default_lava_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "volcano:magma_flowing",
	liquid_alternative_source = "volcano:magma_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

minetest.register_node("volcano:ash", {
	description = "Volcanic Ash",
	tiles = {"volcano_ash.png"},
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.05},
	}),
})

-- ABMs

-- Form conduit from underground lava up against a ceiling of stone with mese or gold

minetest.register_abm({
	nodenames = {
		"default:stone_with_mese",
		"default:stone_with_gold",
		"default:stone_with_diamond",
	},
	neighbors = {"default:lava_source", "default:lava_flowing"},
	interval = CONDINT,
	chance = CONDCHA,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local env = minetest.env
		local x = pos.x
		local y = pos.y
		local z = pos.z
		if env:find_node_near(pos, 1, "volcano:magma_fast") ~= nil
		or env:find_node_near(pos, 1, "volcano:magma_source") ~= nil or y < -256 then
			return
		end
		local nodename = env:get_node({x=x,y=y-1,z=z}).name
		if nodename == "default:lava_source" then
			env:add_node(pos,{name="volcano:magma_fast"})
			print ("[volcano] Conduit forms ("..x.." "..y.." "..z..")")
		end
	end
})

-- Magma rising below sea level

minetest.register_abm({
	nodenames = {"volcano:magma_fast"},
	interval = MAGFINT,
	chance = MAGFCHA,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local env = minetest.env
		local x = pos.x
		local y = pos.y
		local z = pos.z
		for i = -1, 1 do
		for j = 0, 1 do
		for k = -1, 1 do
			if i == 0 and k == 0 then
				if j == 1 then
					if y == -1 then
						env:add_node({x=x,y=0,z=z},{name="volcano:magma_zero"})
					else
						env:add_node({x=x,y=y+1,z=z},{name="volcano:magma_fast"})
					end
				else
					env:add_node(pos,{name="volcano:magma_source"})
				end
			else
				env:add_node({x=x+i,y=y+j,z=z+k},{name="default:obsidian"})
			end
		end
		end
		end
		print ("[volcano] Magma rise ("..x.." "..y.." "..z..")")
	end
})

-- Magma at y = 0, surface check, conduit from sea level to surface

minetest.register_abm({
	nodenames = {"volcano:magma_zero"},
	interval = MAGZINT,
	chance = MAGZCHA,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local env = minetest.env
		local x = pos.x
		local z = pos.z
		local surfy = 1
		for y = 47, 2, -1 do
			local nodename = env:get_node({x=x,y=y,z=z}).name
			if nodename ~= "air" and nodename ~= "ignore" then
				surfy = y
				break
			end
		end
		env:add_node({x=x,y=0,z=z},{name="volcano:magma_source"})
		for y = 1, surfy do
		local vrad = math.ceil(MAXRAD * y / MAXALT)
		for i = -vrad, vrad do
		for k = -vrad, vrad do
			if math.abs(i) == vrad or math.abs(k) == vrad then
				env:add_node({x=x+i,y=y,z=z+k},{name="default:obsidian"})
			elseif y == surfy and i == 0 and k == 0 then
				env:add_node({x=x,y=surfy,z=z},{name="volcano:magma_slow"})
			else
				env:add_node({x=x+i,y=y,z=z+k},{name="volcano:magma_source"})
			end
		end
		end
		end
		print ("[volcano] Magma surfaces ("..x.." "..surfy.." "..z..")")
	end
})

-- Vent rising above surface

minetest.register_abm({
	nodenames = {"volcano:magma_slow"},
	interval = MAGSINT,
	chance = MAGSCHA,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local env = minetest.env
		local y = pos.y
		local rischa = 1.01 - (y / MAXALT)
		if math.random() > rischa then
			return
		end
		local x = pos.x
		local z = pos.z
		local vrad = math.ceil(MAXRAD * y / MAXALT)
		local chalav = LAVCHA / (vrad * 8)
		for j = 0, 1 do
		for i = -vrad, vrad do
		for k = -vrad, vrad do
			if i == 0 and j == 1 and k == 0 and y < MAXALT then
				env:add_node({x=x,y=y+1,z=z},{name="volcano:magma_slow"})
			elseif (math.abs(i) == vrad or math.abs(k) == vrad)
			and (j == 0 or math.random() > chalav or y >= MAXALT) then
				env:add_node({x=x+i,y=y+j,z=z+k},{name="default:obsidian"})
			else
				env:add_node({x=x+i,y=y+j,z=z+k},{name="volcano:magma_source"})
			end
		end
		end
		end
		minetest.add_particlespawner(MAGSINT * 2, MAGSINT * 2,
			{x=x,y=y+1,z=z}, {x=x,y=y+1,z=z},
			{x=-3,y=5,z=-3}, {x=3,y=23,z=3},
			{x=0,y=-9.8,z=0}, {x=0,y=-9.8,z=0},
			2, 4,
			3, 5,
			false, "volcano_magma_particle.png")
		minetest.add_particlespawner(MAGSINT * 2, MAGSINT * 2,
			{x=x-vrad+1,y=y+1,z=z-vrad+1}, {x=x+vrad-1,y=y+1,z=z+vrad-1},
			{x=0,y=3,z=0}, {x=0,y=5,z=0},
			{x=0,y=0,z=0}, {x=0,y=0,z=0},
			7, 11,
			6, 13,
			false, "volcano_ash_particle.png")
		print ("[volcano] Vent rise ("..x.." "..y.." "..z..")")
	end
})

--local vel = {x=0, y=0, z=0}
--local acc = {x=0, y=-9.81, z=0}
--minetest.add_particlespawner(amount, time,
--	minpos, maxpos,
--	vel, vel,
--	acc, acc,
--	exptime, exptime,
--	size, size,
--	false, ".png")

-- Lava cooling

minetest.register_abm({
	nodenames = {"volcano:magma_flowing"},
	interval = COOLINT,
	chance = COOLCHA,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local env = minetest.env
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local ash = false
		local perlin1 = env:get_perlin(SEEDDIFF1, OCTAVES1, PERSISTENCE1, SCALE1)
		local noise1 = perlin1:get3d({x=x,y=y,z=z})
		if math.abs(noise1) <= ASHTHR then
			env:add_node(pos,{name="volcano:ash"})
			ash = true
		else
			env:add_node(pos,{name="default:obsidian"})
		end
		print ("[volcano] Lava cools ("..x.." "..y.." "..z..")")
		for j = 1, 32 do
			local nodename = env:get_node({x=x,y=y-j,z=z}).name
			if nodename == "default:water_source" or nodename == "default:water_flowing" then
				if ash then
					env:add_node({x=x,y=y-j,z=z},{name="default:stone"})
				else
					env:add_node({x=x,y=y-j,z=z},{name="default:obsidian"})
				end
			else
				break
			end
		end
	end
})
