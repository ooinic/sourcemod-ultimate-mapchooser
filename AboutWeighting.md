# Introduction #

> The Weighting system is used when picking maps/groups randomly, in order to specify the "likelihood" of a map/group being picked.

# When Is It Used? #

> The Weighting system is used in various places:  when a vote menu is being populated with maps, maps are chosen from the group at random. How likely a map is going to be picked for inclusion in a vote is determined by its calculated _weight_. This value is calculated via the Weighting system.

> Another case is when a module requests a random map from Ultimate Mapchooser (the [Random Mapcycle module](ModuleRandomCycle.md) does this). How likely it is that the map will be picked is determined by its weight, again calculated via the Weighting system.

# Modules #

> The Weighting system is extended in UMC modules; without any modules adjusting weights, all random selections are uniform (all weights are the same). There are two modules packaged with Ultimate Mapchooser that extend the Weighting system: [Weight](ModuleWeight.md) and [Map Rate Map-Reweighting](ModuleMapRateReweight.md). The first of which allows users to define a "weight" and "group\_weight" option for maps and map groups respectively in a UMC-Mapcycle. The second module will adjust a map's weight based off of it's average rating in the external [Map Rate SourceMod Plugin](http://forums.alliedmods.net/showthread.php?t=69593).