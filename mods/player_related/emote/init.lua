
--[[

Copyright (C) 2016 - Auke Kok <sofar@foo-projects.org>

"emote" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

]]--

emote = {}

local emotes = {
	stand  = {{x =   0, y =  79}, 30, 0, true, "stands up"},
	sit    = {{x =  81, y = 160}, 30, 0, true, "sits"},
	lay    = {{x = 162, y = 166}, 30, 0, true, "lies down"},
	sleep  = {{x = 162, y = 166}, 30, 0, true, "falls asleep"}, -- alias for lay
	wave   = {{x = 192, y = 196}, 15, 0, false, "waves"},
	point  = {{x = 196, y = 196}, 30, 0, true, "points"},
	freeze = {{x = 205, y = 205}, 30, 0, true, "freezes"},
}

local emoting = {}
local attached = {}

-- helper functions
local function facedir_to_look_horizontal(dir)
	if dir == 0 then
		return 0
	elseif dir == 1 then
		return math.pi * 3/2
	elseif dir == 2 then
		return math.pi
	elseif dir == 3 then
		return math.pi / 2
	else
		return nil
	end
end

local function vector_rotate_xz(vec, angle)
	local a = angle - (math.pi * 3/2)
	return {
		x = (vec.z * math.sin(a)) - (vec.x * math.cos(a)),
		y = vec.y,
		z = (vec.z * math.cos(a)) - (vec.x * math.sin(a))
	}
end

-- entity for locked emotes (attached to nodes, etc)
local attacher = {
	description = "Attachment entity for emotes",
	physical = false,
	visual = "upright_sprite",
	visual_size = {x = 1/16, y = 1/16},
	spritediv = {x = 1/16, y = 1/16},
	collisionbox = {-1/16, -1/16, -1/16, 1/16, 1/16, 1/16},
	textures = {"emote_blank.png"},
	init = function(self, player)
		self.player = player
	end,
}

function attacher:on_step(dtime)
	if not self.player then
		self.object:remove()
		return
	end

	local ctrl = self.player:get_player_control()
	if ctrl.jump then
		self:detach()
		return
	end
end

function attacher:detach()
	attached[self.player] = nil
	self.player:set_detach()
	self.player:set_animation(unpack(emotes["stand"]))
	self.object:remove()
	default.player_attached[self.player:get_player_name()] = nil
end

minetest.register_entity("emote:attacher", attacher)

-- API functions

function emote.start(player, emotestring)
	emote.stop(player)
	if emotes[emotestring] then
		player:set_animation(unpack(emotes[emotestring]))
		emoting[player] = emotestring
		local e = emotes[emotestring]
		if e[5] then
			minetest.chat_send_all("* " .. player:get_player_name() .. " " .. e[5])
		end
		if not e[4] then
			local len = (e[1].y - e[1].x) / e[2]
			minetest.after(len, emote.stop, player)
		end
		return true
	else
		return false
	end
end

function emote.stop(player)
	if emoting[player] then
		emoting[player] = nil
		player:set_animation(unpack(emotes["stand"]))
	end
end

function emote.list()
	local r = {}
	for k, _ in pairs(emotes) do
		table.insert(r, k)
	end
	return r
end

function emote.attach_to_node(player, pos, locked)
	local node = minetest.get_node(pos)
	if node.name == "ignore" then
		return false
	end

	if attached[player] then
		return
	end

	local def = minetest.registered_nodes[node.name].emote or {}

	local emotedef = {
		eye_offset = def.eye_offset or {x = 0, y = 1/2, z = 0},
		player_offset = def.player_offset or {x = 0, y = 0, z = 0},
		look_horizontal_offset = def.look_horizontal_offset or 0,
		emotestring = def.emotestring or "sit",
	}

	if locked then
		player:set_animation(unpack(emotes[emotedef.emotestring]))
		local offset = vector_rotate_xz(emotedef.player_offset,facedir_to_look_horizontal(node.param2))
		local object = minetest.add_entity(vector.add(pos, offset), "emote:attacher")
		object:get_luaentity():init(player)
		local rotation = facedir_to_look_horizontal(node.param2) + emotedef.look_horizontal_offset
		object:setyaw(rotation)
		player:set_attach(object, "", emotedef.eye_offset, minetest.facedir_to_dir(node.param2))
		player:set_look_horizontal(rotation)
		-- this is highly unreliable!
		minetest.after(0, function()
			player:set_animation(unpack(emotes[emotedef.emotestring]))
		end)
		attached[player] = object
		default.player_attached[player:get_player_name()] = true
	else
		player:setpos(vector.add(pos, vector_rotate_xz(emotedef.player_offset, facedir_to_look_horizontal(node.param2))))
		player:set_eye_offset(emotedef.eye_offset, {x = 0, y = 0, z = 0})
		player:set_look_horizontal(facedir_to_look_horizontal(node.param2) + emotedef.look_horizontal_offset)
		player:set_animation(unpack(emotes[emotedef.emotestring]))
		player:set_physics_override(0, 0, 0)
	end
end

function emote.attach_to_entity(player, emotestring, obj)
	-- not implemented yet.
end

function emote.detach(player)
	if attached[player] then
		attached[player]:detach()
	end
	-- check if attached?
	player:set_eye_offset(vector.new(), vector.new())
	player:set_physics_override(1, 1, 1)
	player:set_animation(unpack(emotes["stand"]))
end

for k, _ in pairs(emotes) do
	minetest.register_chatcommand(k, {
		params = k .. " emote",
		description = "Makes your character perform the " .. k .. " emote",
		func = function(name, param)
			local player = minetest.get_player_by_name(name)
			emote.start(player, k)
		end,
	})
end


--linus added
minetest.register_chatcommand("ee", {
	func = function(name, param)
		minetest.show_formspec(name, "emote:menu",
				"size[3,7]" ..
				"button[0.5,0;2,1;stand;STAND]" ..
				"button[0.5,1;2,1;sit;SIT]" ..
				"button[0.5,2;2,1;lay;LAY]" ..
				"button[0.5,3;2,1;sleep;SLEEP]" ..
				"button[0.5,4;2,1;wave;WAVE]" ..
				"button[0.5,5;2,1;point;POINT]" ..
				"button[0.5,6;2,1;freeze;FREEZE]"
			)
	end
})

-- Register callback
minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname ~= "emote:menu" then
		return false
	end

	local players = minetest.get_player_by_name(player:get_player_name())

	if fields.stand then emote.start(players, "stand") end
	if fields.sit then emote.start(players, "sit") end
	if fields.lay then emote.start(players, "lay") end
	if fields.sleep then emote.start(players, "sleep") end
	if fields.wave then emote.start(players, "wave") end
	if fields.point then emote.start(players, "point") end
	if fields.freeze then emote.start(players, "freeze") end

	return true
end)


--[[
-- testing tool - punch any node to test attachment code
minetest.register_craftitem("emote:sleep", {
	description = "use me on a bed bottom",
	on_use = function(itemstack, user, pointed_thing)
		-- the delay here is weird, but the client receives a mouse-up event
		-- after the punch and switches back to "stand" animation, undoing
		-- the animation change we're doing.
		minetest.after(0.5, emote.attach_to_node, user, pointed_thing.under)
	end
})
]]--
