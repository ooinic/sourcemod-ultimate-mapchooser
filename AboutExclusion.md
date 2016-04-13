# Introduction #

> Ultimate Mapchooser's Exclusion system checks to see if a map is considered "valid." Ultimate Mapchooser automatically filters out invalid maps so that selected maps are always valid.

# Modules #
> Usually, new Exclusion rules are implemented in modules which extend the Exclusion system. There are two such modules which are packaged with Ultimate Mapchooser:  [Player Limits](ModulePlayerLimits.md) and [Time Limits](ModuleTimeLimits.md), which allow users to specify valid ranges of players and time, respectively. Other Exclusion rules can be implemented in modules by other developers.

# Special Cases #
> The Exclusion system has two special cases: one for nominated maps, and one for maps that are just being used for display, but not for an immediate map change.

> ## Nominated Maps ##
> Nominated maps are considered different because a lot of times server operators want to make special cases for them. Usually, modules which extend the Exclusion system have cvars to control whether or not nominations should be treated differently (the Player Limits and Time Limits modules have this).

> ## Display Maps ##
> Maps which are just being selected for display can also be treated specially (again, most modules have a cvar to control this). An example of such a situation is in the [Nominations module](ModuleNominate.md) when a nomination menu is displayed: the items in the menu are not being used for an immediate map change, so they are treated as "display" maps.