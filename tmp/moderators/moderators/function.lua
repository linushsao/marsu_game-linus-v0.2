--API collection
--here are the function for server


--check if moderator
function is_md0(name)

  for _, player in ipairs(md_0) do
    if player == name then return true end
  end
  return false

end

