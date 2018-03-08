-- Minetest Quests
-- By Sys4

-- This mod add quests based on default minetest game

local mod_sys4_quests = minetest.get_modpath("sys4_quests")
local mod_default = minetest.get_modpath("default")
local mod_farming = minetest.get_modpath("farming")
local mod_wool = minetest.get_modpath("wool")
local mod_dye = minetest.get_modpath("dye")
local mod_beds = minetest.get_modpath("beds")
local mod_boats = minetest.get_modpath("boats")
local mod_fire = minetest.get_modpath("fire")
local mod_screwdriver = minetest.get_modpath("screwdriver")
local mod_tnt = minetest.get_modpath("tnt")
local mod_walls = minetest.get_modpath("walls")
local mod_doors = minetest.get_modpath("doors")
local mod_vessels = minetest.get_modpath("vessels")
local mod_xpanes = minetest.get_modpath("xpanes")
local mod_bucket = minetest.get_modpath("bucket")

if mod_sys4_quests then
   local current_modpath = minetest.get_modpath(minetest.get_current_modname())
   
   if mod_default then
      dofile(current_modpath.."/default.lua")
      
      if mod_farming then
	 dofile(current_modpath.."/farming.lua")
	 
	 if mod_dye then
	    dofile(current_modpath.."/dye.lua")
	 
	    if mod_wool then
	       dofile(current_modpath.."/wool.lua")

	       if mod_beds then
		  dofile(current_modpath.."/beds.lua")
	       end
	    end
	 end
      end
      
      if mod_boats then
	 dofile(current_modpath.."/boats.lua")
      end

      if mod_fire then
	 dofile(current_modpath.."/fire.lua")
      end

      if mod_screwdriver then
	 dofile(current_modpath.."/screwdriver.lua")
      end

      if mod_tnt then
	 dofile(current_modpath.."/tnt.lua")
      end

      if mod_walls then
	 dofile(current_modpath.."/walls.lua")
      end

      if mod_doors then
	 dofile(current_modpath.."/doors.lua")
      end

      if mod_vessels then
	 dofile(current_modpath.."/vessels.lua")
      end

      if mod_xpanes then
	 dofile(current_modpath.."/xpanes.lua")
      end

      if mod_bucket then
	 dofile(current_modpath.."/bucket.lua")
      end
   end
end

