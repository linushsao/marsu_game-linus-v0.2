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
--md_0_privs = {'server','areas','home','shout','fly','fast','basic_privs','protection_bypass','rollback','kick','interact','teleport','ban','supervisor'} --supervisors
      privs.server = true
      privs.areas = true
      privs.home = true
      privs.shout = true
      privs.fly = true
      privs.fast = true
      privs.basic_privs = true
      privs.protection_bypass = true
      privs.rollback = true
      privs.kick = true
      privs.interact = true
      privs.teleport = true
      privs.ban = true
      privs.supervisor = true

      minetest.set_player_privs(name, privs)

  end
  end

end
