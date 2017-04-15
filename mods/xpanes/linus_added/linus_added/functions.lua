
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

function save_table(table,file_name)

  local path_to = minetest.get_worldpath() .. "/"..file_name
  local output = io.open(path_to, "w")
  output:write(minetest.serialize(table).."\n")
  io.close(output)
 end

--codes grab from hudhugry mod & walkinglight mod
-- update hud elemtens if value has changed
local function update_hud(player)
	local name = player:get_player_name()
 --hunger
	local h_out = tonumber(hbhunger.hunger_out[name])
	local h = tonumber(hbhunger.hunger[name])
	if h_out ~= h then
		hbhunger.hunger_out[name] = h
		hb.change_hudbar(player, "satiation", h)
	end
end

-- food functions
function get_food_saturation(item_name)
  if hbhunger.food[item_name] == nil then return 0
  else return hbhunger.food[item_name].saturation
  end
end

local timer = 0
local timer_autoeat = 150 -- time in seconds to check autoeat
minetest.register_globalstep(function(dtime)
  	timer = timer + dtime

    if timer > timer_autoeat then
--      if timer > 3 then
  		timer = 0
  		for _,player in ipairs(minetest.get_connected_players()) do
  		    local name = player:get_player_name()
  		    local h = tonumber(hbhunger.hunger[name])
  		    local hp = player:get_hp()
          local itemstack = player:get_wielded_item()
          local stackid=player:get_wield_index()
          local wielded_item = itemstack:get_name()
--          print("GET WIRLDED ITEM "..wielded_item)
--          print("SATUATION "..get_food_saturation(wielded_item))
          if get_food_saturation(wielded_item) ~= nil and get_food_saturation(wielded_item) ~= 0 then
            if autoeat[name] == "on" then --if autoeat is enable
--              print("START TO AUTOEAT...")
              -- Saturation
  			         if h < 20 then
  				             h = h + get_food_saturation(wielded_item)
  				             hbhunger.hunger[name] = h
--  				             hbhunger.set_hunger_raw(name)
                       itemstack:take_item()
                       player:get_inventory():set_stack("main",stackid,itemstack)

                       -- update all hud elements
                      update_hud(player)

  			         end
            end
          end
      end
    end

  end)
