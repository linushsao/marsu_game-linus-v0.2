
--[[
Circular saw for easy crafting of stairplus-nodes (includes glue for recycling) by Sokomine

    Copyright (C) 2013 Sokomine

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

-- Version 0.2

-- Changelog: 
-- 25.09.13 Fixed a bug that led to item multiplication


circularsaw = {};


-- TODO: make it usable for non-stairplus: stairs

circularsaw.known_stairs = {}


-- register known stairsplus:-stairs
for i,v in ipairs( {"wood","stone","cobble","mossycobble","brick","sandstone","steelblock","desert_stone","glass"} ) do
   table.insert( circularsaw.known_stairs, "default:"..v );
end

if( minetest.get_modpath("technic") ~= nil ) then

   -- technic has its own stairs
   for i,v in ipairs( {"concrete", "marble", "marble_bricks", "granite", "obsidian"} ) do
      table.insert( circularsaw.known_stairs, "technic:"..v );
   end

else

   -- add a copy of the screwdriver from RealBadAngels technic mod
   dofile(minetest.get_modpath("circularsaw").."/technic_screwdriver.lua");
end

   
-- how many microblocks does this shape at the output inventory cost?
circularsaw.cost_in_microblocks = { 6, 4, 7, 2, 1, 3, 3,
                                 6, 4, 7, 2, 1, 3, 3,
                                 6, 2, 7, 2, 6, 3, 0,
                                 4, 2, 7, 0, 6, 3, 0 };

-- anz: amount of input material in microblocks
circularsaw.get_stair_output_inv = function( modname, material, anz, max )

   local max_offered = 99;

   if( not( max ) or (max == nil) or tonumber(max)>99 or tonumber(max)<1) then
      max_offered = 99;
   else
      max_offered = tonumber( max );
   end
   

   -- if there is nothing inside display empty inventory
   if( anz < 1 ) then
      return { "", "", "", "", "", "", "",
               "", "", "", "", "", "", "",
               "", "", "", "", "", "", "",
               "", "", "", "", "", "", ""};
   end

   return { 
    modname.. ":stair_" .. material .. " "                       ..math.min( math.floor( anz/6 ), max_offered ),
    modname.. ":slab_"  .. material .. " "                       ..math.min( math.floor( anz/4 ), max_offered ),
    modname.. ":stair_" .. material .. "_inner "                 ..math.min( math.floor( anz/7 ), max_offered ),
    modname.. ":panel_" .. material .. "_bottom "                ..math.min( math.floor( anz/2 ), max_offered ),
    modname.. ":micro_" .. material .. "_bottom "                ..math.min( math.floor( anz/1 ), max_offered ),
    modname.. ":stair_" .. material .. "_half "                  ..math.min( math.floor( anz/3 ), max_offered ),
    modname.. ":stair_" .. material .. "_wall_half "             ..math.min( math.floor( anz/3 ), max_offered ),


    modname.. ":stair_" .. material .. "_inverted "              ..math.min( math.floor( anz/6 ), max_offered ),
    modname.. ":slab_"  .. material .. "_inverted "              ..math.min( math.floor( anz/4 ), max_offered ),
    modname.. ":stair_" .. material .. "_inner_inverted "        ..math.min( math.floor( anz/7 ), max_offered ),
    modname.. ":panel_" .. material .. "_top "                   ..math.min( math.floor( anz/2 ), max_offered ),
    modname.. ":micro_" .. material .. "_top "                   ..math.min( math.floor( anz/1 ), max_offered ),
    modname.. ":stair_" .. material .. "_half_inverted "         ..math.min( math.floor( anz/3 ), max_offered ),
    modname.. ":stair_" .. material .. "_wall_half_inverted "    ..math.min( math.floor( anz/3 ), max_offered ),


    modname.. ":stair_" .. material .. "_wall "                  ..math.min( math.floor( anz/6 ), max_offered ),
    modname.. ":slab_"  .. material .. "_quarter "               ..math.min( math.floor( anz/2 ), max_offered ),
    modname.. ":stair_" .. material .. "_outer "                 ..math.min( math.floor( anz/7 ), max_offered ),
    modname.. ":panel_" .. material .. "_vertical "              ..math.min( math.floor( anz/2 ), max_offered ),
    modname.. ":slab_"  .. material .. "_three_quarter "         ..math.min( math.floor( anz/6 ), max_offered ),
    modname.. ":stair_" .. material .. "_right_half "            ..math.min( math.floor( anz/3 ), max_offered ),
    "",


    modname.. ":slab_"  .. material .. "_wall "                  ..math.min( math.floor( anz/4 ), max_offered ), 
    modname.. ":slab_"  .. material .. "_quarter_inverted "      ..math.min( math.floor( anz/2 ), max_offered ),
    modname.. ":stair_" .. material .. "_outer_inverted "        ..math.min( math.floor( anz/7 ), max_offered ),
    "",
    modname.. ":slab_"  .. material .. "_three_quarter_inverted "..math.min( math.floor( anz/6 ), max_offered ),
    modname.. ":stair_" .. material .. "_right_half_inverted "   ..math.min( math.floor( anz/3 ), max_offered ),
    "",
  }
end


-- reset empty circularsaw after last full block has been taken out (or the circularsaw has been placed the first tiem); note: max_offered is not reset
circularsaw.reset_circularsaw = function( pos )
   local meta = minetest.env:get_meta(pos);
   local inv  = meta:get_inventory();

   inv:set_list("input", { "" } );
   inv:set_list("micro", { "" } );
   inv:set_list("output", circularsaw.get_stair_output_inv( "", "", 0, meta:get_string("max_offered")));
   meta:set_int("anz", 0 );

   meta:set_string("infotext", "Circular saw, empty (owned by "..( meta:get_string("owner") or "" )..")");
end


-- player has taken something out of the box or placed something inside; that amounts to count microblocks
circularsaw.update_inventory = function( pos, amount )
   local meta = minetest.env:get_meta(pos);
   local inv  = meta:get_inventory();
   local akt  = meta:get_int( "anz" );

   -- the material is receicled automaticly
   inv:set_list("recycle", { "" } );

   if( akt + amount < 1 ) then -- if the last block is taken out

      circularsaw.reset_circularsaw( pos );
      return;

   end
 
   local stack = inv:get_stack( "input", 1 );
   -- at least one "normal" block is necessary to see what kind of stairs are requested
   if( stack:is_empty()) then

      -- any microblocks not taken out yet are now lost (covers material loss in the machine)
      circularsaw.reset_circularsaw( pos );
      return;

   end
   local node_name = stack:get_name();
   local liste = node_name:split( ":");
   local modname  = liste[1];
   local material = liste[2];
  
   -- display as many full blocks as possible
   inv:set_list("input",  { modname.. ":" .. material .. " "..math.floor(    (akt + amount) / 8 ) });

   -- the stairnodes themshelves come frome stairsplus - regardless of their original full blocks
   modname = "stairsplus";

   --print("circularsaw set to "..modname.." : "..material.." with "..(akt+amount).." microblocks.");

   -- 0-7 microblocs may remain as a rest
   inv:set_list("micro",  { modname.. ":micro_" .. material .. "_bottom ".. ((akt + amount) % 8 ) });
   -- display 
   inv:set_list("output", circularsaw.get_stair_output_inv( modname, material,  (akt + amount), meta:get_string("max_offered")));
   -- store how many microblocks are available
   meta:set_int("anz", (akt+amount) );

   meta:set_string("infotext", "Circular saw, working with "..material.." (owned by "..( meta:get_string("owner") or "" )..")");
end


-- the amount of items offered per shape can be configured
circularsaw.on_receive_fields = function(pos, formname, fields, sender)
   local meta = minetest.env:get_meta(pos);
   if( fields.max_offered  and tonumber( fields.max_offered) > 0 and tonumber(fields.max_offered) < 99 ) then
      meta:set_string( "max_offered", fields.max_offered );
      circularsaw.update_inventory( pos, 0 ); -- update to show the correct number of items
   end
end


-- moving the inventory of the circularsaw around is not allowed because it is a fictional inventory
circularsaw.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
    -- moving inventory around would be rather immpractical and make things more difficult to calculate
   return 0;
end


-- only input- and recycle-slot are intended as input slots
circularsaw.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
 
   -- the player is not allowed to put something in there
   if( listname == "output" or listname == "micro" ) then
      return 0;
   end

   local meta = minetest.env:get_meta(pos);
   local inv  = meta:get_inventory();
           
   -- only alow those items that are offered in the output inventory to be recycled
   if( listname == "recycle" and not( inv:contains_item("output", stack:get_name() ))) then
      return 0;
   end

   -- only accept certain blocks as input which are known to be craftable into stairs
   if( listname == "input" ) then
     
      if( not( inv:is_empty("input"))) then

         local old_stack = inv:get_stack("input", 1 );
         if( old_stack:get_name() ~= stack:get_name() ) then
            return 0;
         end
      end

      for i,v in ipairs( circularsaw.known_stairs ) do

        if( circularsaw.known_stairs[ i ] == stack:get_name()) then
           return stack:get_count();
        end

      end
      return 0;
       
   end
 
  return stack:get_count()
end


-- taking is allowed from all slots (even the internal microblock slot)


-- putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material
circularsaw.on_metadata_inventory_put = function(pos, listname, index, stack, player)

   -- we need to find out if the circularsaw is already set to a specific material or not
   local meta = minetest.env:get_meta(pos);
   local inv  = meta:get_inventory();

   -- putting something into the input slot is only possible if that had been empty before or did contain something of the same material
   if(     listname=="input" ) then

      -- each new block is worth 8 microblocks
      circularsaw.update_inventory( pos, 8 * stack:get_count() );
        
   elseif( listname=="recycle" ) then
 
      -- lets look which shape this represents
      for i,v in ipairs( inv:get_list( "output" ) ) do
              
         if( v:get_name() == stack:get_name() ) then
        
            local value = circularsaw.cost_in_microblocks[ i ] * stack:get_count();
            --print("\nRecycling "..( v:get_name() ).." into "..value.." microblocks.");

            -- we get value microblocks back
            circularsaw.update_inventory( pos, value);
         end
      end
   end
end


-- the player takes something
circularsaw.on_metadata_inventory_take = function(pos, listname, index, stack, player)
          
   -- if it is one of the offered stairs: find out how many microblocks have to be substracted
   if(     listname=="output" ) then

      -- we do know how much each block at each position costs
      local cost = circularsaw.cost_in_microblocks[ index ] * stack:get_count();

      circularsaw.update_inventory( pos, -1 * cost );

   elseif( listname=="mikro" ) then

      -- each microblock costs 1 microblock
      circularsaw.update_inventory( pos, -1 * 1 * stack:get_count());

   elseif( listname=="input" ) then
  
      -- each normal (=full) block taken costs 8 microblocks
      circularsaw.update_inventory( pos, -1 * 8 * stack:get_count() );

   end
   -- the recycle field plays no role here since it is processed immediately
end


circularsaw.on_construct_init = function( pos, formspec )

   local meta = minetest.env:get_meta(pos)
   meta:set_string("formspec", formspec ); 

   meta:set_int(    "anz",         0 ); -- no microblocks inside yet
   meta:set_string( "max_offered", 10 ); -- how many items of this kind are offered by default?
   meta:set_string( "infotext",    "Circular saw, empty")

   local inv = meta:get_inventory()
   inv:set_size("input",     1)  -- input slot for full blocks of material x
   inv:set_size("micro",     1)  -- storage for 1-7 surplus microblocks
   inv:set_size("recycle",   1)  -- surplus partial blocks can be placed here
   inv:set_size("output",   28) -- 4x7 versions of stair-parts of material x

   circularsaw.reset_circularsaw( pos );
end


circularsaw.can_dig = function(pos,player)
   local meta = minetest.env:get_meta(pos);
   local inv = meta:get_inventory()
   if not inv:is_empty("input") then
      return false
   elseif not inv:is_empty("micro") then
      return false
   elseif not inv:is_empty("recycle") then
      return false
   end

   -- can be digged by anyone when empty (not only by the owner)
   return true
end,


minetest.register_node("circularsaw:circularsaw", {
        description = "circular saw",

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4, -0.5, -0.4, -0.25, 0.25, -0.25}, --leg
                {0.25, -0.5, 0.25, 0.4, 0.25, 0.4}, --leg
                {-0.4, -0.5, 0.25, -0.25, 0.25, 0.4}, --leg 
                {0.25, -0.5, -0.4, 0.4, 0.25, -0.25}, --leg
                {-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, --table top
                {-0.01, 0.4375, -0.125, 0.01, 0.5, 0.125}, --saw blade (top)
                {-0.01, 0.375, -0.1875, 0.01, 0.4375, 0.1875}, --saw blade (bottom)
                {-0.25, -0.0625, -0.25, 0.25, 0.25, 0.25}, --motor case
            },
        },
        selection_box = {
            type = "regular",
        },
        inventory_image = "circularsaw.png",
        tiles = {"circularsaw_top.png", "circularsaw_bottom.png", "circularsaw_side.png"},

        paramtype = "light",
        is_ground_content = true,

        paramtype2 = "facedir",
        groups = {cracky=2},
        legacy_facedir_simple = true,
        on_construct = function(pos)
           return circularsaw.on_construct_init( pos,
                     "size[10,9]"..
                     "list[current_name;input;0,0;1,1;]"..
                  "label[0,0;Input material]"..
                     "list[current_name;micro;0,1;1,1;]"..
                  "label[0,1;Rest/microblocks]"..
                     "field[0.3,2.5;1,1;max_offered;Max:;${max_offered}]"..
                     "button[1,2;1,1;Set;Set]"..
                     "list[current_name;recycle;0,3;1,1;]"..
                  "label[0,3;Recycle output]"..
                     "list[current_name;output;2,0;7,4;]"..
                     "list[current_player;main;1,5;8,4;]");
        end,

        can_dig = function(pos,player)
           return circularsaw.can_dig( pos, player );
        end,

        -- set owner of this circularsaw
        after_place_node = function(pos, placer)
           local meta = minetest.env:get_meta(pos);
           
           meta:set_string( "owner", ( placer:get_player_name() or "" ));
           meta:set_string( "infotext", "Circular saw, empty (owned by "..( placer:get_player_name() or "" )..")");
        end,

        -- the amount of items offered per shape can be configured
        on_receive_fields = function(pos, formname, fields, sender)
           return circularsaw.on_receive_fields( pos, formname, fields, sender );
        end,

        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
           return circularsaw.allow_metadata_inventory_move( pos, from_list, from_index, to_list, to_index, count, player );     
        end,

        -- only input- and recycle-slot are intended as input slots
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
           return circularsaw.allow_metadata_inventory_put( pos, listname, index, stack, player ); 
        end,

        -- taking is allowed from all slots (even the internal microblock slot); moving is forbidden

        -- putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material
        on_metadata_inventory_put = function(pos, listname, index, stack, player)
           return circularsaw.on_metadata_inventory_put( pos, listname, index, stack, player );
        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)
           return circularsaw.on_metadata_inventory_take( pos, listname, index, stack, player );
        end
          
})



local STAIR = 'stairsplus:stair_cobble';

-- crafting: 8 cobble stairs arranged like cobble/wood for furnace/chest
minetest.register_craft({
        output = 'circularsaw:circularsaw',
        recipe = {
                { STAIR, STAIR, STAIR },
                { STAIR, "",    STAIR },
                { STAIR, STAIR, STAIR },
        }
})


-- and now the same, but as a shared locked object
if( minetest.get_modpath("locks") ~= nil ) then

   minetest.register_craft({
        output = 'circularsaw:circularsaw_shared',
        recipe = {
                { "circularsaw:circularsaw", "locks:lock" },
        }
   });


   minetest.register_node("circularsaw:circularsaw_shared", {
        description = "shared locked circular saw",

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4, -0.5, -0.4, -0.25, 0.25, -0.25}, --leg
                {0.25, -0.5, 0.25, 0.4, 0.25, 0.4}, --leg
                {-0.4, -0.5, 0.25, -0.25, 0.25, 0.4}, --leg 
                {0.25, -0.5, -0.4, 0.4, 0.25, -0.25}, --leg
                {-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, --table top
                {-0.01, 0.4375, -0.125, 0.01, 0.5, 0.125}, --saw blade (top)
                {-0.01, 0.375, -0.1875, 0.01, 0.4375, 0.1875}, --saw blade (bottom)
                {-0.25, -0.0625, -0.25, 0.25, 0.25, 0.25}, --motor case
            },
        },
        selection_box = {
            type = "regular",
        },
        inventory_image = "circularsaw.png",
        tiles = {"circularsaw_top.png", "circularsaw_bottom.png", "circularsaw_side.png"},

        paramtype = "light",
        is_ground_content = true,

        paramtype2 = "facedir",
        groups = {cracky=2},
        legacy_facedir_simple = true,

        on_construct = function(pos)

           locks:lock_init( pos,
                     "size[10,9]"..
                     "list[current_name;input;0,0;1,1;]"..
                  "label[0,0;Input material]"..
                     "list[current_name;micro;0,1;1,1;]"..
                  "label[0,1;Rest/microblocks]"..
                     "field[0.3,2.5;1,1;max_offered;Max:;${max_offered}]"..
                     "button[1,2;1,1;Set;Set]"..
                     "list[current_name;recycle;0,3;1,1;]"..
                  "label[0,3;Recycle output]"..
                     "list[current_name;output;2,0;7,4;]"..
                     "list[current_player;main;1,5;8,4;]"..

                  "field[1.3,4.6;6,0.7;locks_sent_lock_command;Locked saw. Type /help for help:;]"..
                  "button_exit[7.3,4.2;1.7,0.7;locks_sent_input;Proceed]" );

           local meta = minetest.env:get_meta(pos);
           return circularsaw.on_construct_init( pos, meta:get_string( "formspec" ));
        end,

        can_dig = function(pos,player)
           -- instead of empty/not empty we go by privs (diglock priv)
           if( not(locks:lock_allow_dig( pos, player ))) then
              return false;
           end
           return circularsaw.can_dig( pos, player );
        end,

        -- set owner of this circularsaw
        after_place_node = function(pos, placer)
           locks:lock_set_owner( pos, placer, "Shared locked circular saw, empty" );
        end,

        -- the amount of items offered per shape can be configured
        on_receive_fields = function(pos, formname, fields, sender)
            -- if the user already has the right to use this and did input text
            if( fields.max_offered and not(fields.locks_sent_lock_command) and locks:lock_allow_use( pos, sender )) then

               circularsaw.on_receive_fields( pos, formname, fields, sender );

            -- a command for the lock?
            else
               locks:lock_handle_input( pos, formname, fields, sender );
            end

        end,

        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
           if( not( locks:lock_allow_use( pos, player ))) then
              return 0;
           end
           return circularsaw.allow_metadata_inventory_move( pos, from_list, from_index, to_list, to_index, count, player );     
        end,

        -- only input- and recycle-slot are intended as input slots
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
           if( not( locks:lock_allow_use( pos, player ))) then
              return 0;
           end
           return circularsaw.allow_metadata_inventory_put( pos, listname, index, stack, player ); 
        end,

        -- taking is allowed from all slots (even the internal microblock slot); moving is forbidden
        allow_metadata_inventory_take = function( pos, listname, index, stack, player)
           if( not( locks:lock_allow_use( pos, player ))) then
              return 0;
           end
           return stack:get_count();
        end,

        -- putting something in is slightly more complicated than taking anything because we have to make sure it is of a suitable material
        on_metadata_inventory_put = function(pos, listname, index, stack, player)
           return circularsaw.on_metadata_inventory_put( pos, listname, index, stack, player );
        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)
           return circularsaw.on_metadata_inventory_take( pos, listname, index, stack, player );
        end
          
   })
end

