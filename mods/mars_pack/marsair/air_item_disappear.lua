local luaentity = pipeworks.luaentity

local adjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}

local function go_next(pos, velocity, stack)
	local next_positions = {}
	local max_priority = 0
	local cnode = minetest.get_node(pos)
	local cmeta = minetest.get_meta(pos)
	local can_go
	local speed = math.abs(velocity.x + velocity.y + velocity.z)
	if speed == 0 then
		speed = 1
	end
	local vel = {x = velocity.x/speed, y = velocity.y/speed, z = velocity.z/speed,speed=speed}
	if speed >= 4.1 then
		speed = 4
	elseif speed >= 1.1 then
		speed = speed - 0.1
	else
		speed = 1
	end
	vel.speed = speed
	if minetest.registered_nodes[cnode.name] and minetest.registered_nodes[cnode.name].tube and minetest.registered_nodes[cnode.name].tube.can_go then
		can_go = minetest.registered_nodes[cnode.name].tube.can_go(pos, cnode, vel, stack)
	else
		can_go = pipeworks.notvel(adjlist, vel)
	end
	for _, vect in ipairs(can_go) do
		local npos = vector.add(pos, vect)
		pipeworks.load_position(npos)
		local node = minetest.get_node(npos)
		local reg_node = minetest.registered_nodes[node.name]
		if reg_node then
			local tube_def = reg_node.tube
			local tubedevice = minetest.get_item_group(node.name, "tubedevice")
			local tube_priority = (tube_def and tube_def.priority) or 100
			if tubedevice > 0 and tube_priority >= max_priority then
				if not tube_def or not tube_def.can_insert or
						tube_def.can_insert(npos, node, stack, vect) then
					if tube_priority > max_priority then
						max_priority = tube_priority
						next_positions = {}
					end
					next_positions[#next_positions + 1] = {pos = npos, vect = vect}
				end
			end
		end
	end

	if enable_max_limit then
		local h = minetest.hash_node_position(pos)
		local itemcount = tube_item_count[h] or 0
		if itemcount > max_tube_limit then
			cmeta:set_string("the_tube_was", minetest.serialize(cnode))
			print("[Pipeworks] Warning - a tube at "..minetest.pos_to_string(pos).." broke due to too many items ("..itemcount..")")
			minetest.swap_node(pos, {name = "pipeworks:broken_tube_1"})
			pipeworks.scan_for_tube_objects(pos)
		end
	end

	if not next_positions[1] then
		return false, nil
	end

	local n = (cmeta:get_int("tubedir") % (#next_positions)) + 1
	if pipeworks.enable_cyclic_mode then
		cmeta:set_int("tubedir", n)
	end
	local new_velocity = vector.multiply(next_positions[n].vect, vel.speed)
	return true, new_velocity
end

luaentity.registered_entities["pipeworks:tubed_item"].on_step = function(self, dtime)
		local pos = self:getpos()
		if self.start_pos == nil then
			self.start_pos = vector.round(pos)
			self:setpos(pos)
		end

		local stack = ItemStack(self.itemstring)

		local velocity = self:getvelocity()

		local moved = false
		local speed = math.abs(velocity.x + velocity.y + velocity.z)
		if speed == 0 then
			speed = 1
			moved = true
		end
		local vel = {x = velocity.x / speed, y = velocity.y / speed, z = velocity.z / speed, speed = speed}
		local moved_by = vector.distance(pos, self.start_pos)

		if moved_by >= 1 then
			self.start_pos = vector.add(self.start_pos, vel)
			moved = true
		end

		pipeworks.load_position(self.start_pos)
		local node = minetest.get_node(self.start_pos)
		if moved and minetest.get_item_group(node.name, "tubedevice_receiver") == 1 then
			local leftover
			if minetest.registered_nodes[node.name].tube and minetest.registered_nodes[node.name].tube.insert_object then
				leftover = minetest.registered_nodes[node.name].tube.insert_object(self.start_pos, node, stack, vel)
			else
				leftover = stack
			end
			if leftover:is_empty() then
				self:remove()
				return
			end
			velocity = vector.multiply(velocity, -1)
			self:setpos(vector.subtract(self.start_pos, vector.multiply(vel, moved_by - 1)))
			self:setvelocity(velocity)
			self:set_item(leftover:to_string())
			return
		end

		if moved then
			local found_next, new_velocity = go_next(self.start_pos, velocity, stack) -- todo: color
			local rev_vel = vector.multiply(velocity, -1)
			local rev_dir = vector.direction(self.start_pos,vector.add(self.start_pos,rev_vel))
			local rev_node = minetest.get_node(vector.round(vector.add(self.start_pos,rev_dir)))
			local tube_present = minetest.get_item_group(rev_node.name,"tubedevice") == 1
			if not found_next then
				if pipeworks.drop_on_routing_fail or not tube_present or
						minetest.get_item_group(rev_node.name,"tube") ~= 1 then
					-- Using add_item instead of item_drop since this makes pipeworks backward
					-- compatible with Minetest 0.4.13.
					-- Using item_drop here makes Minetest 0.4.13 crash.
					
					--MARS-CHANGE:
					local marsair = minetest.get_item_group(stack:get_name(), "marsair")
					if marsair ~= 1 then
						local dropped_item = minetest.add_item(self.start_pos, stack)
						dropped_item:setvelocity(vector.multiply(velocity, 5))
					end
					--END
					self:remove()
					return
				else
					velocity = vector.multiply(velocity, -1)
					self:setpos(vector.subtract(self.start_pos, vector.multiply(vel, moved_by - 1)))
					self:setvelocity(velocity)
				end
			end

			if new_velocity and not vector.equals(velocity, new_velocity) then
				local nvelr = math.abs(new_velocity.x + new_velocity.y + new_velocity.z)
				self:setpos(vector.add(self.start_pos, vector.multiply(new_velocity, (moved_by - 1) / nvelr)))
				self:setvelocity(new_velocity)
			end
		end
	end