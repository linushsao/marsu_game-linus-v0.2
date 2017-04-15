Under Sky
=========

Minetest mod by Shara RedCat which adds a black skybox at height -100 to prevent the default skybox (and sun) showing through the walls of caves which have not fully loaded. This improves atmosphere and makes caves as dark as caves should be.

Checks are in place so players using noclip underground to gain an overview of cave systems will not experience the black skybox.


Settings
--------

If you wish to change the height below which the black skybox appears, adjust the value of sky_start, on line 2 of the init.lua file. This is set to -100 by default.

If using this mod on a server, you may also wish to adjust the timer on line 28 to a higher value (for example 5 instead of 2), so that checks are less frequent and performance is improved. 


Licenses and Attribution 
-----------------------

This mod is released under MIT (https://opensource.org/licenses/MIT). 
