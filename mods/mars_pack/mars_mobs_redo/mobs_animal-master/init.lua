
local path = minetest.get_modpath("mobs_animal")

-- Intllib
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
mobs.intllib = S

-- Animals

dofile(path .. "/chicken.lua") -- JKmurray
dofile(path .. "/cow.lua") -- KrupnoPavel
dofile(path .. "/rat.lua") -- PilzAdam
dofile(path .. "/sheep.lua") -- PilzAdam
dofile(path .. "/warthog.lua") -- KrupnoPavel
dofile(path .. "/bee.lua") -- KrupnoPavel
dofile(path .. "/bunny.lua") -- ExeterDad
dofile(path .. "/kitten.lua") -- Jordach/BFD
dofile(path .. "/penguin.lua") -- D00Med

dofile(path .. "/lucky_block.lua")

print (S("[MOD] Mobs Redo 'Animals' loaded"))
