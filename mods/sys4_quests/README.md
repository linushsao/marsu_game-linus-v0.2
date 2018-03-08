# sys4_quests
By Sys4

A ModPack for Minetest 0.4.14

Work for solo and multiplayer.
Work only with Minetest 0.4.14.

This modpack provide :
* An api for easily make quests (sys4_quests)
* It also provide already written quests. (minetest_quests, ...)

##TARGET :
You have to follow proposed quests and finish them to unlock craft of items they unlock.
Otherwise if you intent to craft a locked item, you will obtain a waste item.

##INSTALLATION :
Download the source code and place it in a new folder named "sys4_quests" into the mod folder of minetest.

##DEPENDS :
* sys4_quests

    quests (By TeTpaAka),
    intllib?

* minetest_quests

    sys4_quests,
    default,
    moreores?,
    intllib?

* 3d_armor_quests

    minetest_quests,
    3d_armor mod pack by (stujones11),
    moreores_quests?,
    ethereal_quests?,
    intllib?

* mobs_quests

    minetest_quests,
    mobs redo by (TenPlus1),
    intllib?

* unified_inventory_quests

    minetest_quests,
    unified_inventory (by RealBadAngel),
    intllib?

* moreores_quests

    minetest_quests,
    moreores (by Calinou),
    intllib?

* thirsty_quests

    minetest_quests,
    thirsty (by Ben),
    ethereal_quests?,
    intllib?

* ethereal_quests

    minetest_quests,
    ethereal NG (by TenPlus1),
    moreblocks_quests?,
    intllib?

* moreblocks_quests

    minetest_quests,
    moreblocks (by Calinou),
    intllib?

* carts_quests

    minetest_quests,
    carts (by PilzAdam) or boost_cart (by SmallJoker)
    moreores_quests?
    intllib?

##CONFIGURATION :
* You can change the level of difficulty by editing the local variable "level" in sys4_quests/init.lua" file.
* By default the level is 12 but for an easier gameplay you can set it down to 1. Or above 12 if you want a more difficult gameplay.
* Because the numbers of quests may be consequent, you would to increase the number of displayed quests by editing the file "hud.lua" of the "quests" mod and set the local variable "show_max" to 15 or 20.

##CHAT COMMANDS :
* /craftmode [on|off]  : Enable or not locked crafts. (default is on)
* /bookmode [on|off]   : Enable or not written books that shows you how to craft unlocked items when you finish a quest. (default is off)
* /lqg [group index]   : Display groups of quests or display quests of a group if group index is given as argument.
* /iquest "quest_name" : Display infos of the quest.
* /fquest "quest_name" : Force an active quest to be immediately finished.
* /itemqq "item"       : Display the quest to finish which unlock this item.
* /getcraft "item"     : Display craft recipes of this item.