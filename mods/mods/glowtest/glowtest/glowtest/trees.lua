-- TREE FUNCTIONS

-- Green

function glowtest_sgreentree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:greenleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function glowtest_mgreentree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:greenleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function add_tree_branch_green(pos)
	minetest.env:add_node(pos, {name="glowtest:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:greenleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:greenleaf"})
				end
			end
		end
	end
end

function glowtest_lgreentree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:tree"})
				if i == height then
					add_tree_branch_green({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_green({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_green({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_green({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_green({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_green(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_green(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
				if i == height then
					add_tree_branch_green({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_green({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_green({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_green({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_green({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_green({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_green({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_green({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_green({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_green({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_green({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_green({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
			end
		end
end

-- Blue

function glowtest_sbluetree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:blueleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function glowtest_mbluetree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:blueleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function add_tree_branch_blue(pos)
	minetest.env:add_node(pos, {name="glowtest:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:blueleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:blueleaf"})
				end
			end
		end
	end
end

function glowtest_lbluetree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:tree"})
				if i == height then
					add_tree_branch_blue({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_blue({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_blue({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_blue({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_blue({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_blue(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_blue(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
				if i == height then
					add_tree_branch_blue({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_blue({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_blue({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_blue({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_blue({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_blue({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_blue({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_blue({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_blue({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_blue({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_blue({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_blue({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
			end
		end
end

-- Pink

function glowtest_spinktree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:pinkleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function glowtest_mpinktree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:pinkleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function add_tree_branch_pink(pos)
	minetest.env:add_node(pos, {name="glowtest:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:pinkleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:pinkleaf"})
				end
			end
		end
	end
end

function glowtest_lpinktree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:tree"})
				if i == height then
					add_tree_branch_pink({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_pink({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_pink({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_pink({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_pink({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_pink(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_pink(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
				if i == height then
					add_tree_branch_pink({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_pink({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_pink({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_pink({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_pink({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_pink({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_pink({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_pink({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_pink({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_pink({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_pink({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_pink({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
			end
		end
end

-- Yellow

function glowtest_syellowtree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:yellowleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function glowtest_myellowtree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:yellowleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function add_tree_branch_yellow(pos)
	minetest.env:add_node(pos, {name="glowtest:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:yellowleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:yellowleaf"})
				end
			end
		end
	end
end

function glowtest_lyellowtree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:tree"})
				if i == height then
					add_tree_branch_yellow({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_yellow({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_yellow({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_yellow(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_yellow(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
				if i == height then
					add_tree_branch_yellow({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_yellow({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_yellow({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_yellow({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_yellow({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_yellow({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_yellow({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_yellow({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_yellow({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
			end
		end
end

-- White

function glowtest_swhitetree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:whiteleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function glowtest_mwhitetree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:whiteleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:tree"})
	end
end

function add_tree_branch_white(pos)
	minetest.env:add_node(pos, {name="glowtest:tree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:whiteleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:whiteleaf"})
				end
			end
		end
	end
end

function glowtest_lwhitetree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:tree"})
				if i == height then
					add_tree_branch_white({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_white({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_white({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_white({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_white({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:tree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_white(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_white(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
				if i == height then
					add_tree_branch_white({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_white({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_white({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_white({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_white({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_white({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_white({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_white({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_white({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_white({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_white({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_white({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:tree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:tree"})
				end
			end
		end
end

-- Red

function glowtest_sredtree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:redleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:stonetree"})
	end
end

function glowtest_mredtree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:redleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:stonetree"})
	end
end

function add_tree_branch_red(pos)
	minetest.env:add_node(pos, {name="glowtest:stonetree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:redleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:redleaf"})
				end
			end
		end
	end
end

function glowtest_lredtree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:stonetree"})
				if i == height then
					add_tree_branch_red({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_red({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_red({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_red({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_red({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:stonetree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_red(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_red(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
				end
				if i == height then
					add_tree_branch_red({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_red({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_red({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_red({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_red({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_red({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_red({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_red({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_red({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_red({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_red({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_red({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
				end
			end
		end
end

--Black

function glowtest_sblacktree(pos)
	local t = 3 + math.random(2) -- trunk height
	for j = -2, t do
		if j == t or j == t - 2 then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:blackleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:stonetree"})
	end
end

function glowtest_mblacktree(pos)
	local t = 6 + math.random(4) -- trunk height
	for j = -3, t do
		if j == math.floor(t * 0.7) or j == t then
			for i = -2, 2 do
			for k = -2, 2 do
				local absi = math.abs(i)
				local absk = math.abs(k)
				if math.random() > (absi + absk) / 24 then
					minetest.add_node({x=pos.x+i,y=pos.y+j+math.random(0, 1),z=pos.z+k},{name="glowtest:blackleaf"})
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="glowtest:stonetree"})
	end
end

function add_tree_branch_black(pos)
	minetest.env:add_node(pos, {name="glowtest:stonetree"})
	for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
		for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do
			local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name="glowtest:blackleaf"})
			end
			local chance = math.abs(i+k)
			if (chance < 1) then
				p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
				n = minetest.env:get_node(p)
				if (n.name=="air") then
					minetest.env:add_node(p, {name="glowtest:blackleaf"})
				end
			end
		end
	end
end

function glowtest_lblacktree(pos)
    local height = 10 + math.random(5)
		if height < 10 then
			for i = height, -2, -1 do
				local p = {x=pos.x, y=pos.y+i, z=pos.z}
				minetest.env:add_node(p, {name="glowtest:stonetree"})
				if i == height then
					add_tree_branch_black({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
					add_tree_branch_black({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_black({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
					add_tree_branch_black({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
					add_tree_branch_black({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
				end
				if i < 0 then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="glowtest:stonetree"})
				end
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_black(branch_pos)
				end
			end
		else
			for i = height, -5, -1 do
				if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
					branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
					add_tree_branch_black(branch_pos)
				end
				if i < math.random(0,1) then
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
				end
				if i == height then
					add_tree_branch_black({x=pos.x+1, y=pos.y+i, z=pos.z+1})
					add_tree_branch_black({x=pos.x+2, y=pos.y+i, z=pos.z-1})
					add_tree_branch_black({x=pos.x, y=pos.y+i, z=pos.z-2})
					add_tree_branch_black({x=pos.x-1, y=pos.y+i, z=pos.z})
					add_tree_branch_black({x=pos.x+1, y=pos.y+i, z=pos.z+2})
					add_tree_branch_black({x=pos.x+3, y=pos.y+i, z=pos.z-1})
					add_tree_branch_black({x=pos.x, y=pos.y+i, z=pos.z-3})
					add_tree_branch_black({x=pos.x-2, y=pos.y+i, z=pos.z})
					add_tree_branch_black({x=pos.x+1, y=pos.y+i, z=pos.z})
					add_tree_branch_black({x=pos.x+1, y=pos.y+i, z=pos.z-1})
					add_tree_branch_black({x=pos.x, y=pos.y+i, z=pos.z-1})
					add_tree_branch_black({x=pos.x, y=pos.y+i, z=pos.z})
				else
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="glowtest:stonetree"})
					minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="glowtest:stonetree"})
				end
			end
		end
end

-- SAPLINGS

-- Green Sapling

minetest.register_abm({
    nodenames = {"glowtest:sgreensapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_sgreentree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mgreensapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mgreentree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lgreensapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lgreentree(pos)
    end,
})

--Blue Sapling

minetest.register_abm({
    nodenames = {"glowtest:sbluesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_sbluetree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mbluesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mbluetree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lbluesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lbluetree(pos)
    end,
})

--Pink Sapling

minetest.register_abm({
    nodenames = {"glowtest:spinksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_spinktree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mpinksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mpinktree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lpinksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lpinktree(pos)
    end,
})

--Yellow Sapling

minetest.register_abm({
    nodenames = {"glowtest:syellowsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_syellowtree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:myellowsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_myellowtree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lyellowsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lyellowtree(pos)
    end,
})

--White Sapling

minetest.register_abm({
    nodenames = {"glowtest:swhitesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_swhitetree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mwhitesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mwhitetree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lwhitesapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lwhitetree(pos)
    end,
})

--Red Sapling

minetest.register_abm({
    nodenames = {"glowtest:sredsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_sredtree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mredsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mredtree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lredsapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lredtree(pos)
    end,
})

--Black Sapling

minetest.register_abm({
    nodenames = {"glowtest:sblacksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_sblacktree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:mblacksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_mblacktree(pos)
    end,
})

minetest.register_abm({
    nodenames = {"glowtest:lblacksapling"},
    interval = GREINT,
    chance = GRECHA,
    action = function(pos, node, active_object_count, active_object_count_wider)
		glowtest_lblacktree(pos)
    end,
})