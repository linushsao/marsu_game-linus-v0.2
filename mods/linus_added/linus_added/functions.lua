
--extra functions for other mods
function sky_change(player,ratio)

  if ratio > 0.83 or ratio < 0.18 then
--  print("STARRY NIGHT@@@@@@@@@@@@")
  player:set_sky({r=0, g=0, b=0},"skybox",{"marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky_star.png","marssurvive_space_sky.png","marssurvive_space_sky.png","marssurvive_space_sky.png"})
  else
    if ratio < 0.5 then ratio = 1*(ratio/0.5)
    else
      if ratio > 0.8 then ratio = 1 end
      ratio = (1-ratio)/0.5
    end
--  	print("TIME RATOI in globalsetup:"..ratio)
    player:set_sky({r=math.floor(219*ratio), g=math.floor(168*ratio), b=20+math.floor(117*ratio)},"plain",{})
  end
end

function if_air(pos)

	n=minetest.get_node({x=pos.x,y=pos.y+2,z=pos.z}).name
	if n=="air" then
		return 0.1
		else
		return 1
	end
end

function if_fire(pos)

	n=minetest.get_node({x=pos.x,y=pos.y+2,z=pos.z}).name
	if n=="air" then
		return "default_furnace_fire_fg-1.png"
		else
		return "default_furnace_fire_fg.png"
	end

end
