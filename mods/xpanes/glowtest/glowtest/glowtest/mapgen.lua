local MAXALT = 23
local MINSPA = 2
local MAXSPA = 11
local NORMPLANT = 16
local RAREPLANT = 25
local LOWALT = -10

local SEEDDIFF = 104
local OCTAVES = 3
local PERSISTENCE = 0.5
local SCALE = 200

local NOISEH = -0.6
local NOISEL = -1.2

local GREINT = 23
local GRECHA = 13

local ONGEN = true
local REMOVE_TREES = true
local DEBUG = true

local colchamin = MINSPA ^ 2
local factor = (MAXSPA ^ 2 - colchamin) * 4
local nav = (NOISEH + NOISEL) / 2
local nra = NOISEH - NOISEL

if ONGEN then
	minetest.register_on_generated(function(minp, maxp, seed)
		if minp.y == -32 then
			local perlin = minetest.env:get_perlin(SEEDDIFF, OCTAVES, PERSISTENCE, SCALE)
			local x0 = minp.x
			local z0 = minp.z
			local x1 = maxp.x
			local z1 = maxp.z
			local xl = x1 - x0
			local zl = z1 - z0
			if not (perlin:get2d({x=x0, y=z0}) > NOISEL and perlin:get2d({x=x0, y=z0}) < NOISEH)
			and not (perlin:get2d({x=x0, y=z1}) > NOISEL and perlin:get2d({x=x0, y=z1}) < NOISEH)
			and not (perlin:get2d({x=x1, y=z0}) > NOISEL and perlin:get2d({x=x1, y=z0}) < NOISEH)
			and not (perlin:get2d({x=x1, y=z1}) > NOISEL and perlin:get2d({x=x1, y=z1}) < NOISEH)
			and not (perlin:get2d({x=x0, y=z0+(zl/2)}) > NOISEL and perlin:get2d({x=x0, y=z0+(zl/2)}) < NOISEH)
			and not (perlin:get2d({x=x1, y=z0+(zl/2)}) > NOISEL and perlin:get2d({x=x1, y=z0+(zl/2)}) < NOISEH)
			and not (perlin:get2d({x=x0+(xl/2), y=z0}) > NOISEL and perlin:get2d({x=x0+(xl/2), y=z0}) < NOISEH)
			and not (perlin:get2d({x=x0+(xl/2), y=z1}) > NOISEL and perlin:get2d({x=x0+(xl/2), y=z1}) < NOISEH)
			and not (perlin:get2d({x=x0+(xl/2), y=z0+(zl/2)}) > NOISEL and perlin:get2d({x=x0+(xl/2), y=z0+(zl/2)}) < NOISEH) then
				return
			end

			if REMOVE_TREES == true then
				local trees = minetest.env:find_nodes_in_area(minp, maxp, {"default:leaves","default:tree","default:apple"})
				for i,v in pairs(trees) do
					minetest.env:remove_node(v)
				end
				--if DEBUG then
				--	print ("[glowtest] Trees Removed ("..minp.x.." "..minp.y.." "..minp.z..")")
				--end
			end
			for i = 0, xl do
			for j = 0, zl do
				local x = x0 + i
				local z = z0 + j
				local noise = perlin:get2d({x = x, y = z})
				if noise > NOISEL and noise < NOISEH then
					local colcha = colchamin + math.floor(factor * (math.abs(noise - nav) / nra) ^ 2)
					if math.random(1,colcha) == 1 then
						local ground_y = nil
						for y=maxp.y,minp.y,-1 do
							local nodename = minetest.env:get_node({x=x,y=y,z=z}).name
							if nodename ~= "air" and nodename ~= "default:water_source" then
								ground_y = y
								break
							end
						end
						if ground_y and ground_y <= MAXALT  then
							local nodename = minetest.env:get_node({x=x,y=ground_y,z=z}).name
							local junnear = minetest.env:find_node_near({x=x,y=ground_y,z=z}, MINSPA, "default:jungletree")
							local defnear = minetest.env:find_node_near({x=x,y=ground_y,z=z}, MINSPA, "default:tree")
							if nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 16 then
								glowtest_sgreentree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 2 then
                                        glowtest_mgreentree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 3 then
                                        glowtest_lgreentree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 4 then
                                        glowtest_sbluetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 5 then
                                        glowtest_mbluetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 6 then
                                        glowtest_lbluetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 7 then
                                        glowtest_spinktree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 8 then
                                        glowtest_mpinktree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 9 then
                                        glowtest_lpinktree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 10 then
                                        glowtest_syellowtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 11 then
                                        glowtest_myellowtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 12 then
                                        glowtest_lyellowtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 13 then
                                        glowtest_swhitetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 14 then
                                        glowtest_mwhitetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(NORMPLANT) == 15 then
                                        glowtest_lwhitetree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 16 then
								glowtest_sredtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 2 then
                                        glowtest_mredtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 3 then
                                        glowtest_lredtree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 4 then
                                        glowtest_sblacktree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 5 then
                                        glowtest_mblacktree({x=x,y=ground_y+1,z=z})
                                        elseif nodename == "default:desert_sand" and math.random(NORMPLANT) == 6 then
                                        glowtest_lblacktree({x=x,y=ground_y+1,z=z})
                                        
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(RAREPLANT) == 1 then
                                        minetest.add_node({x=x,y=ground_y+1,z=z},{name="glowtest:blue_crystal_1"})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(RAREPLANT) == 2 then
                                        minetest.add_node({x=x,y=ground_y+1,z=z},{name="glowtest:green_crystal_1"})
                                        elseif nodename == "default:desert_sand" and math.random(RAREPLANT) == 3 then
                                        minetest.add_node({x=x,y=ground_y+1,z=z},{name="glowtest:red_crystal_1"})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(RAREPLANT) == 4 then
                                        minetest.add_node({x=x,y=ground_y+1,z=z},{name="glowtest:yellow_crystal_1"})
                                        elseif nodename == "default:dirt_with_grass" and junnear == nil and defnear == nil and math.random(RAREPLANT) == 5 then
                                        minetest.add_node({x=x,y=ground_y+1,z=z},{name="glowtest:pink_crystal_1"})
							end
						end
					end
				end
			end
			end
		end
	end)
end