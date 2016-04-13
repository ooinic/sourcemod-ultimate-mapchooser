# Purpose #
> The Player Limits module extends Ultimate Mapchooser's exclusion system to allow users to specify, in their UMC-Mapcycle definitions, a range of players to be on the server for a map is available. Specifically, it defines two new group options **"default\_min\_players"** and **"default\_max\_players"**, and two new map options **"min\_players"** and **"max\_players"**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "default_min_players"  "X"
        "default_max_players"  "X"
        ...

        "A Map"
        {
            "min_players"  "X"
            "max_players"  "X"
            ...
        }
    }
    ...
}
```
> Where **X** is the number of players on the server. The group options specify the defaults for all the maps in the group, in the event that the maps do not define their own "min\_players" and "max\_players" options.

# Example #
```
"umc_mapcycle"
{
    "GroupA"
    {
        "default_min_players"  "0"
        "default_max_players"  "12"

        "MapAA"
        {
        }

        "MapBA"
        {
        }
    }

    "GroupB"
    {
        "default_min_players"  "13"
        "default_max_players"  "24"

        "MapAB"
        {
            "max_players"  "18"
        }

        "MapBB"
        {
        }
    }
}
```
> This example defines two Map Groups, "GroupA" and "GroupB", and two maps in each group.  "GroupA" has the options "default\_min\_players" and "default\_max\_players" set so that all its maps are by default available if the server has between 0 and 12 players (inclusive). Since none of it's maps specify "min\_players" or "max\_players", these defaults are not overridden and are used by both maps.

> In "GroupB", "default\_min\_players" and "default\_max\_players" are set so that the group is available between 13 and 14 players (inclusive). "MapAB" has defined a "max\_players" of 18, thus making it's player count range 13 to 18 players. "MapBB" does not specify it's own "min\_players" or "max\_players," so it will use the defaults for "GroupB."

# List of CVars #
> The list of cvars for the Time Limits module is located in **cfg/sourcemod/umc-timelimits.cfg**.
```
// Determines if maps being displayed are exempt from being excluded due to Player Limits.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_playerlimits_display "0"

// Determines if nominations are exempt from being excluded due to Player Limits.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_playerlimits_nominations "0"
```