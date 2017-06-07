--API collection
--here are the function for server


--check if moderator
function is_md0(name)

  for _, player in ipairs(md_0) do
    if player == name then return true end
  end
  return false

end

--retuen suit's texture according to normal player or md/supervisors
function textures_switch(player)

  local suit_md0 = "marssurvive_sp_startrek_md0.png"
  local suit_normal = "marssurvive_sp_white.png"
--  local suit_default = "character.png"
  if player == nil then return suit_normal end
  if is_md0(player) then return suit_md0
  else return suit_normal
  end

end

function recovery_md0_privs()

  for _, name in ipairs(md_0) do

  if is_md0(name) then
      local privs = minetest.get_player_privs(name)
      minetest.set_player_privs(name,{})
      local privs = minetest.get_player_privs(name)

      privs.server = true
      privs.areas = true
      privs.bring = true
      privs.home = true
      privs.shout = true
      privs.fly = true
      privs.fast = true
      privs.noclip = true
      privs.basic_privs = true
      privs.protection_bypass = true
      privs.rollback = true
      privs.kick = true
      privs.interact = true
      privs.teleport = true
      privs.ban = true
      privs.supervisor = true
      privs.wiki_admin = true
      privs.wiki = true
      privs.give = true
      privs.creative = true


      minetest.set_player_privs(name, privs)

  end
  end

end

--save mars_config
function save_mars_config(index,pos,name)

			if (index == nil or pos == nil or name == nil) then return end

			mars_conf[index]={x=pos.x,y=pos.y,z=pos.z}

			local mars_config_file = minetest.get_worldpath() .. "/mars_conf"
			local output = io.open(mars_config_file, "w")
			if output == nil then return
			else
			output:write(minetest.serialize(mars_conf).."\n")
			io.close(output)
      end

end

--save ALL_mars_config
function save_all_mars_config()
			local mars_config_file = minetest.get_worldpath() .. "/mars_conf"
			local output = io.open(mars_config_file, "w")
			if output == nil then return end
			output:write(minetest.serialize(mars_conf).."\n")
			io.close(output)
end
