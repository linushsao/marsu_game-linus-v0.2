minetest.register_craftitem("zombies:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "mobs_rotten_flesh.png",
	on_use = minetest.item_eat(1),
})


-- Zombie by BlockMen

mobs:register_mob("zombies:zombie", {
	type = "monster",
	passive = false,
	pathfinding = true,
	attack_type = "dogfight",
	damage = 3,
	reach = 3,
	hp_min = 20,
	hp_max = 35,
	armor = 150,
	collisionbox = {-0.25, -1, -0.3, 0.25, 0.75, 0.3},
	visual = "mesh",
	mesh = "creatures_mob.x",
	textures = {
		{"mobs_zombie.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie",
		damage = "mobs_zombie_hit",
		attack = "groan",
		death = "mobs_zombie_death",
	},
	walk_velocity = 0.5,
	run_velocity = 0.5,
	jump = true,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "default:coal_lump",
		chance = 2, min = 3, max = 5,},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 5,
		speed_run = 5,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		--punch_start = 168,
		--punch_end = 188,
	},
})


-- 1 Arm

mobs:register_mob('zombies:1arm', {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 2,
	hp_min = 3,
	hp_max = 15,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "zombie_one-arm.b3d",
	textures = {
		{"mobs_zombie.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie",
		damage = "mobs_zombie_hit",
		attack = "groan",
		death = "mobs_zombie_death",
	},
	walk_velocity = 0.5,
	run_velocity = 0.5,
	jump = true,
	view_range = 15,
	drops = {
		{name = "zombies:rotten_flesh",
		chance = 2, min = 3, max = 5,},
	},
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 2,
	animation = {
		speed_normal = 5,
		speed_run = 5,
		punch_speed = 20,
		walk_start = 0,
		walk_end = 20,
		run_start = 0,
		run_end = 20,
		punch_start = 21,
		punch_end = 51,
	},
})


-- Crawler

mobs:register_mob('zombies:crawler', {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 1,
	hp_min = 1,
	hp_max = 10,
	armor = 80,
	collisionbox = {-0.5, -.5, -0.4, 0.5, 0.2, 0.4},
	visual = "mesh",
	mesh = "zombie_crawler.b3d",
	textures = {
		{"mobs_zombie.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie",
		damage = "mobs_zombie_hit",
		attack = "groan",
		death = "mobs_zombie_death",
	},
	walk_velocity = 0.1,
	run_velocity = 0.1,
	jump = true,
	view_range = 15,
	drops = {
		{name = "zombies:rotten_flesh",
		chance = 2, min = 3, max = 5,},
	},
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 2,
	animation = {
		speed_normal = 10,
		speed_run = 10,
		punch_speed = 60,
		walk_start = 0,
		walk_end = 40,
		run_start = 0,
		run_end = 40,
		punch_start = 41,
		punch_end = 71,
	},
})


-- Normal

mobs:register_mob('zombies:normal', {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 1,
	hp_min = 1,
	hp_max = 10,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "zombie_normal.b3d",
	textures = {
		{"mobs_zombie.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_zombie",
		damage = "mobs_zombie_hit",
		attack = "groan",
		death = "mobs_zombie_death",
	},
	walk_velocity = 0.25,
	run_velocity = 0.25,
	jump = true,
	view_range = 15,
	drops = {
		{name = "zombies:rotten_flesh",
		chance = 2, min = 3, max = 5,},
	},
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 2,
	animation = {
		speed_normal = 20,
		speed_run = 20,
		punch_speed = 20,
		stand_start = 0,
            	stand_end = 40,
		walk_start = 41,
		walk_end = 101,
		run_start = 41,
		run_end = 101,
		punch_start = 102,
		punch_end = 142,
	},
})


-- Spawns

mobs:register_spawn("zombies:zombie",{"bones:bones_infection"}, 5, 0, 1, 1, 31000)
--mobs:register_spawn("zombies:1arm", {"cityscape:road_broken", "cityscape:sidewalk_broken", "default:gravel"}, 15, 0, 70, 10, 170, false)
--mobs:register_spawn("zombies:crawler", {"cityscape:road_broken", "cityscape:sidewalk_broken", "default:gravel"}, 15, 0, 70, 10, 170, false)
--mobs:register_spawn("zombies:normal", {"cityscape:road_broken", "cityscape:sidewalk_broken", "default:gravel"}, 15, 0, 70, 10, 170, false)


-- Eggs

--mobs:register_egg("zombies:zombie", "Zombie", "zombie_head.png", 0)
--mobs:register_egg("zombies:1arm", "One Armed Zombie", "zombie_head.png", 0)
--mobs:register_egg("zombies:crawler", "Crawling Zombie", "zombie_head.png", 0)
--mobs:register_egg("zombies:normal", "Zombie 2", "zombie_head.png", 0)
