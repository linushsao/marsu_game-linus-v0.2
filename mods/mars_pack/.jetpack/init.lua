dofile(minetest.get_modpath("jetpack") .. "/config.lua")

jetpack = {max_charge = 200000, wear_per_step = 200, dtime = 0}

minetest.register_tool('jetpack:jetpack', {
    description = "Jetpack",
    inventory_image = "jetpack.png",
    stack_max = 1,
    on_refill = technic.refill_RE_charge,
    wear_represents = "technic_RE_charge",
})

--[[jetpack_particle_default = {
	velocity = {x=0, y=-10, z=0},
	acceleration = {x=0, y=10, z=0},
	expirationtime = 0.5,
	size = 2,
	collisiondetection = true,
	glow = 15,
	texture = "fire_basic_flame.png",
}]]--

minetest.register_craft({
        output = "jetpack:jetpack",
        recipe = {
            {"default:steel_ingot", "", "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
            {"default:steel_ingot", "", "default:steel_ingot"},
        },
})


technic.register_power_tool('jetpack:jetpack', jetpack.max_charge)

minetest.register_globalstep(function(dtime)
	if jetpack.dtime < 2 then
		jetpack.dtime = jetpack.dtime + dtime
		return
	else
		jetpack.dtime = 0
	end
	for i ,player in ipairs(minetest.get_connected_players()) do
		local pname = player:get_player_name()
		local inv = player:get_inventory()
		local jetpack_stack = inv:get_stack('main', 2)
		local privs = minetest.get_player_privs(pname)
		print(0, privs.basic_privs, privs.fly)
		if not jetpack_stack:get_name():find('jetpack:') then 
			if not (privs.basic_privs == true) then
				print(1)
				privs.fly = nil
				minetest.set_player_privs(pname, privs)
			end
			return
		end
		
		local wear_per_step = jetpack.wear_per_step
		local meta = minetest.deserialize(jetpack_stack:get_metadata())
		if meta and meta.charge and meta.charge >= wear_per_step+2 then
			print(2, privs.fly)
			if not privs.fly then
				privs.fly = true
			end
			--[[if math.random(3) == 1 then
				local particle = jetpack_particle_default
				ppos = player:getpos()
				local spawnxz = player:get_look_dir()
				spawnxz.y=0
				spawnxz = vector.multiply(vector.normalize(spawnxz),-0.6)
				ppos = vector.add(ppos, spawnxz)
				ppos.x = ppos.x+(-2+math.random(4))/10
				ppos.z = ppos.z+(-2+math.random(4))/10
				particle.pos = ppos
				minetest.add_particle(particle)
			end]]--

			meta.charge = meta.charge - wear_per_step
			technic.set_RE_wear(jetpack_stack, meta.charge, 
					jetpack.max_charge)
			jetpack_stack:set_metadata(minetest.serialize(meta))
			inv:set_stack('main', 2, jetpack_stack)
		else
			print(3, privs.basic_privs)
			if not (privs.basic_privs == true) then
				privs.fly = nil
			end
		end
		print(4, privs.fly)
		--minetest.set_player_privs(pname, privs)
		print(dump(minetest.get_player_privs(pname)))
	end
end)






--[[if jetpack.fast == true then
    playereffects.register_effect_type("flyj", "Fly mode available", "jetpack.png", {"fly"},
        function(player)
            local playername = player:get_player_name()
            local privs = minetest.get_player_privs(playername)
            privs.fly = true
            privs.fast = true
            minetest.set_player_privs(playername, privs)
        end,
        function(effect, player)
            local privs = minetest.get_player_privs(effect.playername)
            privs.fly = nil
            privs.fast = nil
            minetest.set_player_privs(effect.playername, privs)
        end,
        false,
        false)
    else
        playereffects.register_effect_type("flyj", "Fly mode available", "jetpack.png", {"fly"},
            function(player)
                local playername = player:get_player_name()
                local privs = minetest.get_player_privs(playername)
                privs.fly = true
                minetest.set_player_privs(playername, privs)
            end,
            function(effect, player)
                local privs = minetest.get_player_privs(effect.playername)
                privs.fly = nil
                minetest.set_player_privs(effect.playername, privs)
            end,
            false,
            false)
end

minetest.register_tool("jetpack:jetpack", {
    description = "Jetpack",
    inventory_image = "jetpack.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack.time, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_tool("jetpack:jetpack_bronze", {
    description = "Bronze Jetpack",
    inventory_image = "jetpack_bronze.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack.time_bronze, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_tool("jetpack:jetpack_gold", {
    description = "Gold Jetpack",
    inventory_image = "jetpack_gold.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack.time_gold, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

if jetpack.crafts == true and minetest.get_modpath("default") ~= nil then
    minetest.register_craftitem("jetpack:jetpack_base", {
        description = "Jetpack Tubes",
        inventory_image = "jetpack_base.png",
    })
    minetest.register_craft({
        output = "jetpack:jetpack",
        recipe = {
            {"default:diamond", "jetpack:jetpack_base", "default:diamond"},
            {"default:mese_crystal", "default:steelblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "jetpack:jetpack_bronze",
        recipe = {
            {"default:diamondblock", "jetpack:jetpack_base", "default:diamond"},
            {"default:mese", "default:bronzeblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "jetpack:jetpack_gold",
        recipe = {
            {"default:diamondblock", "jetpack:jetpack_base", "default:diamondblock"},
            {"default:mese", "default:goldblock", "default:mese"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
end

--Not sure if this is a hack, but it stops unkown items appearing if jetpack.crafts is set to false, while removing them from the creative inventory.
if jetpack.crafts == false then
    minetest.register_craftitem("jetpack:jetpack_base", {
        description = "Jetpack Tubes",
        inventory_image = "jetpack_base.png",
        groups = {not_in_creative_inventory = 1},
    })
end]]--
