--API collection
--here are the function for server


--check if moderator
function is_md0(name)

  for _, player in ipairs(md_0) do
    if player == name then return true end
  end
  return false

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
