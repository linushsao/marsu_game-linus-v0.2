--Created by Krock for the BitChange mod
local mod_path = minetest.get_modpath("bitchange")

dofile(mod_path.."/config.txt")
dofile(mod_path.."/minecoins.lua")
if(bitchange_use_moreores_tin or bitchange_use_technic_zinc or bitchange_use_gold) then
	dofile(mod_path.."/moreores.lua")
end
if(bitchange_enable_exchangeshop) then
	dofile(mod_path.."/shop.lua")
end
if(bitchange_enable_moneychanger) then
	dofile(mod_path.."/moneychanger.lua")
end
if(bitchange_enable_warehouse) then
	dofile(mod_path.."/warehouse.lua")
end
if(bitchange_bank_type ~= "") then
	if(minetest.get_modpath(bitchange_bank_type) ~= nil) then
		dofile(mod_path.."/bank_"..bitchange_bank_type..".lua")
	else
		print("[BitChange] Bank: Type or mod not found or enabled: "..bitchange_bank_type)
	end
end

if(not minetest.setting_getbool("creative_mode") and bitchange_initial_give > 0) then
	-- Giving initial money
	minetest.register_on_newplayer(function(player)
		player:get_inventory():add_item("main", "bitchange:mineninth "..bitchange_initial_give)
	end)
end
print("[BitChange] Loaded.")