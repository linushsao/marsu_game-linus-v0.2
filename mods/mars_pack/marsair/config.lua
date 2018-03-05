--time after that air disappears without by going trought the wall or so
--because in real u can't hold air endless in any building
marsairconfig.leak_time = 30*60
marsairconfig.leak_chance = 50

--the count of air-units a generator needs to generate air
marsairconfig.need_air_generation_count = 8
--the count of air-units the generator needs to fix the air leak after
--marsairconfig.leak_time see above
marsairconfig.need_air_fixleak_count = 4

--the time one flower needs to generate an air-unit
marsairconfig.flower_air_time = 2*60
--the chance to generate air by flower after flower_air_time
marsairconfig.flower_air_chance = 3.333

--same with tree
marsairconfig.tree_air_time = 5*60
marsairconfig.tree_air_chance = 10

--the time until the tree-air becomes normal air and disappear
marsairconfig.tree_air_disappear_time = 10
--the interval after which the tree_air_maker checks for new air
marsairconfig.tree_air_maker_time = 8

--the speed after which the air (marsair:air_stable) next to vacuum (air)
--goes to disappear
marsairconfig.vacuum_leak_speed = 8
--the chance for air disappear after vacuum_leak_speed next to vacuum
marsairconfig.vacuum_leak_chance = 5
